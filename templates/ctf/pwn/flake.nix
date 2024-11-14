{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (python312.withPackages (pp: [
              pp.pwntools
              pp.requests
              pp.more-itertools
            ]))
            gdb
            pwndbg
            # pwninit # - maybe look at this later?
            ghidra
          ];
        };
      }
    );
}
