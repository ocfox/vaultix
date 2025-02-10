# beforeUserborn

+ type: `list of string`

For deploying secrets and templates that required before user init.

List of [id](#id-state) of templates or secrets.

example:

```nix
beforeUserborn = ["secret1" "secret2" "template1"];
```
