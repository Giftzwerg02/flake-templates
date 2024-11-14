{
  description = "My nix flake templates";

  outputs = {
    self,
    
    nixpkgs,
  }: let
      createTemplate = nixpkgs.lib;
  in {
    templates = {
        test = {
          path = ./ctf/pwn;
          description = "foobar";
        };
    };
  };
}
