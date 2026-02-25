{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
            gcc
            gnumake
            gdb
            linux-manual 
            man-pages 
            man-pages-posix

            glfw
            sdl3
            slang
            freetype
            vulkan-headers
            vulkan-loader
            vulkan-validation-layers
            vulkan-tools
            shaderc
            renderdoc
            tracy
            vulkan-tools-lunarg
          ];

          LD_LIBRARY_PATH="${pkgs.glfw}/lib:${pkgs.freetype}/lib:${pkgs.vulkan-loader}/lib:${pkgs.vulkan-validation-layers}/lib:${pkgs.sdl3}/lib";
          VULKAN_SDK = "${pkgs.vulkan-headers}";
          VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
        };
      }
    );
}

