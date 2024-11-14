{
  description = "My nix flake templates";

  outputs = {
    self,
    
    nixpkgs,
  }: let
      createTemplate = lib;
  in {
    templates = {
    };
  };
}
