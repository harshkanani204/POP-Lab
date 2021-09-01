with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    mlton
    smlnj
    rlwrap
    gnumake
  ];
}
