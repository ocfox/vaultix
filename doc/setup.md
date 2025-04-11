# setup

You could also find the minimal complete nixos configuration on [CI VM test](https://github.com/milieuim/vaultix/tree/main/dev).

### Layout Preview

```nix
{
  withSystem,
  self,
  inputs,
  ...
}:
{
  flake = {

    vaultix = {
      nodes = self.nixosConfigurations;
      identity = "/home/who/private_key"; # age identity file path
    };

    nixosConfigurations.host-name = withSystem "x86_64-linux" ({ system, ... }:
      inputs.nixpkgs.lib.nixosSystem (
          {
            inherit system;
            specialArgs = {
              inherit self; # Required
            };
            modules = [
              inputs.milieuim.nixosModules.vaultix # import nixosModule

              (
                { config, ... }:
                {
                  services.userborn.enable = true; # or systemd.sysuser, required

                  vaultix = {
                    settings.hostPubkey = "ssh-ed25519 AAAAC...";
                    secrets.test-secret-1 = {
                      file = ./secrets/there-is-a-secret.age;
                    };
                  };
                }
              )
              ./configuration.nix
            ];
          }
      )
    );
  };
}
```

And you will be able to invoke secrets in module, like:

```
{
  services.proxy1.environmentFile = config.vaultix.secrets.example.path;
}
# ...
```
