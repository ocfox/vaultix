set shell := ["nu", "-c"]

pwd := `pwd`

default:
    @just --choose

build-package:
    nix build .

clean-exist-deploy:
    #!/usr/bin/env nu
    sudo umount /run/vaultix.d
    sudo rm -r /run/vaultix.d
    sudo rm -r /run/vaultix
full-test:
    #!/usr/bin/env nu
    cargo test
    just vm-tests
eval-tester:
    nix eval .#nixosConfigurations.tester.config.system.build.toplevel
vm-tests:
    #!/usr/bin/env nu
    nix run github:nix-community/nixos-anywhere -- --flake .#tester --vm-test
