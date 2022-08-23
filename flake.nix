{
  description = "Environment for PoPL course at IIT Palakkad";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          devShell = pkgs.mkShell {
            buildInputs = [
                pkgs.editorconfig-checker
                pkgs.mlton
                pkgs.smlnj
                pkgs.rlwrap
                pkgs.gnumake
              ];
          };
        }
    );
}
