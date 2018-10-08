let

  pkgs = import <nixpkgs> {};

  cholmodExtra = import ./default.nix;

in with pkgs; stdenv.mkDerivation rec {

  name = "cholmod-extra-tests";

  src = ./.;

  buildPhase = ''
    make tests
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp Build/cholmod_test_spinv $out/bin
  '';

  buildInputs = [ suitesparse gfortran cholmodExtra openblas gdb ];

  meta = with stdenv.lib; {
    homepage = https://github.com/jluttine/cholmod-extra;
    description = "A set of additional routines for SuiteSparse CHOLMOD Module";
    license = with licenses; [ gpl2Plus ];
    maintainers = with maintainers; [ jluttine ];
    platforms = with platforms; unix;
  };

}
