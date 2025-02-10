# NixOS Module Options


This is in nixosConfiguration, produced by `nixosSystem` function. Any confusion about this please refer to [our test system config](https://github.com/milieuim/vaultix/blob/7b14c948e7d7a8e86ed5ee4c5927c588ee344db7/dev/test.nix#L16) and [unofficial doc](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-configuration-explained)

Configurable option could be divided into 3 parts:

```nix
# in configuration.nix etc.
{
  imports = [ inputs.vaultix.nixosModules.default ];
  vaultix = {
    settings = {
      hostPubkey = "ssh-ed25519 AAAA..."; # required
      # ...
    };
    secrets = { };
    templates = { };
    beforeUserborn = [ ];
  };
}
```
