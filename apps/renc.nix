{
  nodes,
  lib,
  pkgs,
  package,
  identity,
  cache,
  extraPackages,
  pinentryPackage,
  ...
}:
let
  inherit (pkgs) writeShellScriptBin;
  inherit (lib)
    concatStringsSep
    attrValues
    makeBinPath
    filter
    optionalString
    getExe
    ;
  bin = getExe package;

  profilesArgs = concatStringsSep " " (
    map (
      v:
      "--profile"
      + " "
      + (pkgs.writeTextFile {
        name = "vaultix-material";
        text = builtins.toJSON {
          inherit (v.config.vaultix)
            beforeUserborn
            placeholder
            secrets
            settings
            templates
            ;
        };
      })
    ) (filter (v: v.config ? vaultix) (attrValues nodes))
  );

  rencCmds = "${bin} ${profilesArgs} renc --identity ${identity} --cache ${cache}";

  pathPrefix = makeBinPath extraPackages;

in
writeShellScriptBin "renc" ''
  export PATH=${pathPrefix}:$PATH
  ${optionalString (pinentryPackage != null) "export PINENTRY_PROGRAM=${getExe pinentryPackage}"}
  ${rencCmds}
''
