with import <nixpkgs> {};
with pkgs.python36Packages;




{ allowBroken = true; 
  allowUnfree = true;
  ignoreCollisions = true;
  

  packageOverrides = pkgs: with pkgs; {


    myPythonEnv = python36.withPackages (ps: with ps; [numpy astropy ipython scipy]);


    my_plugins = {inherit (pkgs) vimUtils fetchFromGitHub; };
    configurable_nix_path = "${<nixpkgs>}/pkgs/applications/editors/vim/configurable.nix";
    myVim = pkgs.vimUtils.makeCustomizable (callPackage configurable_nix_path{
      inherit(darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
      inherit(darwin) libobjc cf-private;
      features = "huge";
      lua = pkgs.lua5_1;
      gui = "gtk";
      python=python36;

      flags = ["python3" "X11"];

    });

    EverythingEnv = pkgs.buildEnv {

      name = "LiterallyEverything";
      ignoreCollisions = true;
      paths =[
        myVim
        myPythonEnv
        myBuildTools
        myCompilers
        #myDebugTools
        myVersionControl
        mySystemTools
        emacs
        gcc

      ];

    };

    myBuildTools = pkgs.buildEnv {

      name = "BuildTools";
      paths = [
        cmake
        automake
        autoconf
        scons
      ];
      
    };

    myCompilers = pkgs.buildEnv {
     
      name = "Compilers";
      paths = [
        gcc
        rustc
        go
        ocaml
        nodejs
      ];
    };

    myDebugTools = pkgs.buildEnv {
      name = "DebugTools";
      paths = [
        gdb
      ];
    };

    myVersionControl = pkgs.buildEnv {
      name = "VersionControlTools";
      paths = [
        git
        git-lfs
      ];
    };

    mySystemTools = pkgs.buildEnv {
      name = "SystemTools";
      paths = [
        bash
        gnutar
        htop
        screen
        tmux
      ];
    };

   
    cython = buildPythonPackage rec {
    name = "Cython-${version}";
    version = "0.25.2";

    src = pkgs.fetchurl {
      url = "mirror://pypi/C/Cython/${name}.tar.gz";
      sha256 = "01h3lrf6d98j07iakifi81qjszh6faa37ibx7ylva1vsqbwx2hgi";
    };

    # On i686-linux and Python 2.x this test fails because the result is "3L"
    # instead of "3", so let's fix it in-place.
    #
    # Upstream issue: https://github.com/cython/cython/issues/1548
    #    postPatch = optionalString (stdenv.isi686 && !isPy3k) ''
    # sed -i -e 's/\(>>> *\)\(verify_resolution_GH1533()\)/\1int(\2)/' \
    #   tests/run/cpdef_enums.pyx
    #'';

    buildInputs = with self; [ pkgs.glibcLocales pkgs.pkgconfig pkgs.gdb ];
    # For testing
    #nativeBuildInputs = with self; [ numpy pkgs.ncurses ];

    LC_ALL = "en_US.UTF-8";

    # cython's testsuite is not working very well with libc++
    # We are however optimistic about things outside of testsuite still working
    doCheck = false;
  };

  astropy = buildPythonPackage rec {
    name = "astropy";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/51/88/c8c4355ff49f40cc538405e86af3395e76a8f9063a19cc5513a7c364d36d/astropy-1.3.tar.gz";
      sha256 = "49de3e86482abe24e3cd02c4a30a469ee4b928d5b46ea5f70fa605ff6f9c6d38";      
  };
  doCheck = false;
  buildInputs = with python36Packages; [ numpy ];
};

  

  myValgrind = stdenv.mkDerivation {
    name = "valgrind";
    buildInputs = [ gnu.mig ];
    src = pkgs.fetchurl {
      url = "http://www.valgrind.org/downloads/valgrind-3.12.0.tar.bz2";
      sha256 = "67ca4395b2527247780f36148b084f5743a68ab0c850cb43e4a5b4b012cf76a1";
    };
  };


  };
  
  
}




