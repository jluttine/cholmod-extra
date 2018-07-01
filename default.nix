let

  pkgs = import <nixpkgs> {};

in with pkgs; stdenv.mkDerivation rec {

  name = "cholmod-extra";

  src = ./.;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    make install INSTALL_LIB=$out/lib INSTALL_INCLUDE=$out/include
  '';

  buildInputs = [ suitesparse gfortran ];

  meta = with stdenv.lib; {
    homepage = https://github.com/jluttine/cholmod-extra;
    description = "A set of additional routines for SuiteSparse CHOLMOD Module";
    license = with licenses; [ gpl2Plus ];
    maintainers = with maintainers; [ jluttine ];
    platforms = with platforms; unix;
  };

}
