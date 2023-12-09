# https://status.nixos.org
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05.tar.gz") {} }:
# { mach-nix ? import (fetchTarball "https://github.com/DavHau/mach-nix/tarball/3.5.0") {} }:

let
  python-packages = pkgs.python3.withPackages (p: with p; [
    jinja2
    kubernetes
    netaddr
    rich
    mkdocs
  ]);
  mach-nix = import (builtins.fetchGit {
    url = "https://github.com/DavHau/mach-nix/";
    # place version number with the latest one from the github releases page
    ref = "refs/tags/3.5.0";
  }) {
    python = "python38";
    pypiDataRev = "d88506bb5efd223737f1fe642fb7806365565c80";
    pypiDataSha256 = "1p1b0k53iclfj9ci92k9bf733k4hllzidcspy637fh8zjcaw62xw";
  };
  mkdocs-packages = mach-nix.mkPython {
    requirements = builtins.readFile ./docs/requirements.txt;
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    ansible
    ansible-lint
    bmake
    diffutils
    docker
    docker-compose_1 # TODO upgrade to version 2
    git
    go
    grc
    iproute2
    k9s
    kube3d
    kubectl
    kubernetes-helm
    kustomize
    libisoburn
    neovim
    openssh
    p7zip
    pre-commit
    shellcheck
    terraform
    terragrunt
    yamllint

    cilium-cli

    python-packages
    mkdocs-packages
  ];
}
