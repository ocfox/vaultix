## Templates

`Vaultix` provides templating function. This makes it able to insert secrets content into plaintext config while deploying.

Overview of this option:

```nix
templates = {
  test-template = {
    name = "template.txt";
    content = "this is a template for testing ${config.vaultix.placeholder.example}";
    trim = true;

    # permission options like secrets
    mode = "640"; # default 0400
    owner = "root";
    group = "users";
    name = "example.toml";
    path = "/some/place";
  };
}
```


### content


Insert `config.vaultix.placeholder.example` in plain string content.

This expects the `placeholder.<*>` identical with defined secret `id` (the keyof it).

<div id="id-state"></div>

```nix
secrets = {
  # the id is 'example' here.
  example = {
    file = ./secret/example.age;
  };
};
```

The content could also be multiline:
```nix
''
this is a template for testing ${config.vaultix.placeholder.example}
this is another ${config.vaultix.placeholder.what}
${config.vaultix.placeholder.some} here
''
```

> [!NOTE]
> Source secret text may have trailing `\n`, if you don't want automatically remove it please see [trim](#trim):

### trim

+ type: `bool`
+ default: `true`

Removing trailing and leading whitespace by default.
