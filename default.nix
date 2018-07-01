let

  pkgs = import <nixpkgs> {};

in with pkgs; stdenv.mkDerivation rec {

  pname = "cholmod-extra";
  version = "1.1.0";
  name = "${pname}-${version}";

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
