# https://status.nixos.org
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.11.tar.gz") {} }:
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
  }) {};
  mkdocs-packages = mach-nix.mkPython {
    requirements = builtins.readFile ./docs/requirements.txt;
  };
  # cillium = pkgs.mkDerivation {
  #   pname = "cillium";
  #   version = "0.0.1";
  #   buildInputs = with pkgs; [ curl ];
  #   phases = [ "installPhase" ];
  #   installPhase = ''
  #     CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
  #     CLI_ARCH=amd64

  #     if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
  #     curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
  #     sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
  #     sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
  #     rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
  #   '';
  # };
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
    yamllint

    python-packages
    mkdocs-packages
  ];
}
