{
  fetchFromGitHub,
  freshrss,
  jq,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "freshrss-catppuccin";
  version = "0-unstable-2025-10-17";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "freshrss";
    rev = "b3675ee72d0edc6c6c9b5230971a213948b77bc3";
    sparseCheckout = [ "/themes/" ];
    nonConeMode = true;
    hash = "sha256-flBhMin/4/LdlZSxvJpMLcs67HT6R6u4imqennawJlA=";
  };

  nativeBuildInputs = [ jq ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    themeDir="$out/p/themes/catppuccin-mocha"
    mkdir -p "$themeDir"
    cp -r ${freshrss}/p/themes/Nord/. "$themeDir/"
    chmod -R u+w "$themeDir"
    cp themes/catppuccin-mocha.css "$themeDir/catppuccin.css"
    jq '.name = "Catppuccin Mocha"
      | .description = "Catppuccin Mocha colors for Nord"
      | ."theme-color" = "#1e1e2e"
      | .files += ["catppuccin.css"]' \
      "$themeDir/metadata.json" > "$themeDir/metadata.json.tmp"
    mv "$themeDir/metadata.json.tmp" "$themeDir/metadata.json"
    runHook postInstall
  '';
}
