locals {
  records = merge({}, [
    for zone, config in local.dns : merge({}, [
      for group in config.record_groups : merge({}, [
        for host, types in group : merge({}, [
          for type, records in merge(
            { for type, value in types : type => { main = { content = tostring(value) } } if can(tostring(value)) },
            { for type, value in types : type => value if !can(tostring(value)) },
            ) : {
            for key, record in records : "${zone}/${host}/${type}/${key}" => merge(record, {
              zone_id = config.zone_id
              name    = host == "@" ? zone : "${host}.${zone}"
              type    = type
            })
          }
        ]...)
      ]...)
    ]...)
  ]...)
}

resource "cloudflare_dns_record" "records" {
  for_each = local.records

  zone_id  = each.value.zone_id
  name     = each.value.name
  type     = each.value.type
  content  = try(each.value.content, null)
  data     = try(each.value.data, null)
  ttl      = try(each.value.ttl, 1)
  proxied  = try(each.value.proxied, false)
  priority = try(each.value.priority, null)
  comment  = try(each.value.comment, null)
  tags     = try(each.value.tags, [])
  settings = try(each.value.settings, each.value.type == "CNAME" ? {
    flatten_cname = false
    ipv4_only     = false
    ipv6_only     = false
  } : null)
  include_shadow_metadata = false
}
