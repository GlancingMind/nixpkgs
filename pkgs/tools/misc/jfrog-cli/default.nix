{ lib
, buildGoModule
, fetchFromGitHub
, pkgs
}:

buildGoModule rec {
  pname = "jfrog-cli";
  version = "2.38.5";

  src = fetchFromGitHub {
    owner = "jfrog";
    repo = "jfrog-cli";
    rev = "refs/tags/v${version}";
    hash = "sha256-fd5YJCaqT78TjhC3CkX7+iPTxW278U7GTiXLH46L2m4=";
  };

  vendorHash = "sha256-6sUifqqryPrlwOFYPKp1VrgGE+xF/ELz8s7eLrMJnr4=";

  postInstall = ''
    # Name the output the same way as the original build script does
    mv $out/bin/jfrog-cli $out/bin/jf
  '';

  # Some of the tests require a writable $HOME
  preCheck = "export HOME=$TMPDIR";

  meta = with lib; {
    homepage = "https://github.com/jfrog/jfrog-cli";
    description = "Client for accessing to JFrog's Artifactory and Mission Control through their respective REST APIs";
    changelog = "https://github.com/jfrog/jfrog-cli/releases/tag/v${version}";
    license = licenses.asl20;
    mainProgram = "jf";
    maintainers = with maintainers; [ detegr ];
  };
}
