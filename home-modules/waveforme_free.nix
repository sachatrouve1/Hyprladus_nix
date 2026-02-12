{ config, pkgs, lib, ... }:

let
  waveform = pkgs.stdenv.mkDerivation rec {
    pname = "waveform-free";
    version = "13.3.2"; # adapte si Tracktion met à jour

    src = ./

    nativeBuildInputs = [
      pkgs.dpkg
      pkgs.autoPatchelfHook
      pkgs.makeWrapper
    ];

    buildInputs = [
      pkgs.alsa-lib
      pkgs.jack2
      pkgs.pipewire
      pkgs.libGL
      pkgs.xorg.libX11
      pkgs.xorg.libXcursor
      pkgs.xorg.libXrandr
      pkgs.xorg.libXinerama
      pkgs.freetype
      pkgs.fontconfig
      pkgs.glib
      pkgs.gtk3
      pkgs.nss
      pkgs.curl
    ];

    unpackPhase = ''
      dpkg-deb -x $src .
    '';

    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out/

      # binaire principal
      chmod +x $out/bin/Waveform*
    '';

    postFixup = ''
      wrapProgram $out/bin/Waveform* \
        --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath buildInputs}
    '';
  };
in
{
  options.programs.waveform-free.enable = lib.mkEnableOption "Waveform Free DAW";

  config = lib.mkIf config.programs.waveform-free.enable {
    environment.systemPackages = [ waveform ];
  };
}
