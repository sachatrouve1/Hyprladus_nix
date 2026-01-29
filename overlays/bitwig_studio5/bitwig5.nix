final: prev: {
  bitwig-studio-unwrapped = (prev.callPackage ./package.nix {}).overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      cp ${./bitwig.jar} $out/libexec/bitwig-studio/bin/bitwig.jar
    '';
  });
}
