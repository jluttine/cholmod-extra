let
  pkgs = import <nixpkgs> {};
in with pkgs; let
  suitesparse_ = suitesparse;
in let
  # SuiteSparse must use the same openblas
  suitesparse = suitesparse_.override { inherit openblas; };
in stdenv.mkDerivation rec {

  name = "cholmod-extra";

  src = ./.;

  buildInputs = [ suitesparse gfortran openblas ];

  buildFlags = [
    "BLAS=-lopenblas"
  ];

  installFlags = [
    "INSTALL_LIB=$(out)/lib"
    "INSTALL_INCLUDE=$(out)/include"
  ];

  doCheck = true;

  meta = with stdenv.lib; {
    homepage = https://github.com/jluttine/cholmod-extra;
    description = "A set of additional routines for SuiteSparse CHOLMOD Module";
    license = with licenses; [ gpl2Plus ];
    maintainers = with maintainers; [ jluttine ];
    platforms = with platforms; unix;
  };

}
