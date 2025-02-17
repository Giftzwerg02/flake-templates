{
  description = "My nix flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    lib = nixpkgs.lib;
    templateName = path:
      assert builtins.isPath path;
        let
          name = lib.last (
          builtins.split
          "/templates/"
          (toString path)
        );
        in
          if lib.strings.hasSuffix "/default" name then
            lib.head (builtins.split "/default" name)
          else if lib.strings.hasSuffix "/templates" name then 
            "default" 
          else 
            name;

    templatePaths =
      lib.map (p: builtins.dirOf p)
      (
        lib.filter
        (p: builtins.baseNameOf p == "flake.nix")
        (lib.filesystem.listFilesRecursive ./templates)
      );

    createTemplate = path:
      assert builtins.isPath path; {
        name = templateName path;
        value = {
          inherit path;
          description = "Template for: ${templateName path}";
        };
      };
  in {
    templates =
      builtins.listToAttrs
      (lib.map createTemplate templatePaths);
  };
}
