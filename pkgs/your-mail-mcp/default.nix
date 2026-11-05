{
  lib,
  buildGo127Module,
  fetchFromGitHub,
  makeWrapper,
  isync,
  notmuch,
  w3m,
}:
buildGo127Module {
  pname = "your-mail-mcp";
  version = "0-unstable-2026-11-04";
  src = fetchFromGitHub {
    owner = "wildsurfer";
    repo = "your-mail-mcp";
    rev = "7e76cc303b9868cb0dec4fd54a45dad5a83f8b0d";
    hash = "sha256-SpQNbihS1HvXh9deiUt1l0BeGBZe2IyyfrV4wppA1u4=";
  };
  vendorHash = "sha256-mCR9tVDBAfTr0E9V22yEsGWRXaNeZF0W1ot2afMe38I=";
  env.CGO_ENABLED = 0;
  nativeBuildInputs = [ makeWrapper ];
  nativeCheckInputs = [
    isync
    notmuch
    w3m
  ];
  postFixup = ''
    wrapProgram $out/bin/your-mail-mcp \
      --prefix PATH : ${
        lib.makeBinPath [
          isync
          notmuch
          w3m
        ]
      }
  '';
  __darwinAllowLocalNetworking = true;
  meta = {
    description = "Read-only IMAP MCP server with native HTTP and OAuth";
    homepage = "https://github.com/wildsurfer/your-mail-mcp";
    license = lib.licenses.mit;
    mainProgram = "your-mail-mcp";
    platforms = lib.platforms.unix;
  };
}
