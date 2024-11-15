{
  description = "My nix flake templates";

  outputs = {
    self,
    nixpkgs,
  }: let
    lib = nixpkgs.lib;
    templateName = path:
      assert builtins.isPath path;
        lib.last (
          builtins.split
          "flake-templates/templates/"
          (toString path)
        );

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
