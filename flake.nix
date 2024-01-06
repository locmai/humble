{
  description = "Humble";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/3bf71cb5a36130f566bb6ae7574533db52403f00";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # TODO remove unfree after removing Terraform
        # (Source: https://xeiaso.net/blog/notes/nix-flakes-terraform-unfree-fix)
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = [
            ansible
            ansible-lint
            bmake
            diffutils
            docker
            docker-compose_1 # TODO upgrade to version 2
            git
            go
            gotestsum
            iproute2
            jq
            k9s
            kanidm
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
            terragrunt
	    terraform # TODO replace with OpenTofu, Terraform is no longer FOSS
            yamllint

            (python3.withPackages (p: with p; [
              jinja2
              kubernetes
              mkdocs-material
              netaddr
              pexpect
              rich
            ]))
          ];
        };
      }
    );
}
