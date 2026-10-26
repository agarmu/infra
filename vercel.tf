resource "vercel_project" "website" {
  name      = "website"
  team_id   = "team_uDAMjEr3JulpW5wHp0xcBLdg"
  framework = "astro"

  git_repository = {
    type = "github"
    repo = "agarmu/website"
  }
}

resource "vercel_project_domain" "website" {
  domain     = "agarmu.com"
  project_id = vercel_project.website.id
  team_id    = vercel_project.website.team_id
}

data "vercel_domain_config" "website" {
  domain             = vercel_project_domain.website.domain
  project_id_or_name = vercel_project.website.id
  team_id            = vercel_project.website.team_id
}
