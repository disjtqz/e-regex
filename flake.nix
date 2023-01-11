{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/master";
    devshell.url = "github:numtide/devshell/master";
  };
  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
          config.allowUnfree = true;
        };

      in
      rec {
        nixConfig.sandbox = "relaxed";
        devShell = pkgs.devshell.mkShell {
          name = "e-regex";
          commands = [
            {
              name = "build";
              help = "Automatically configure build folder and run build";
              command = "meson setup -C build --buildtype=debug; meson compile -C build";
            }
            {
              name = "run_tests";
              help = "Run tests";
              command = "ninja -C build test";
            }
          ];
          env = [
          ];
          packages =
            with pkgs;
            [
              meson
              ninja
              gcc12
            ];
        };
      });
}
