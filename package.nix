{
  lib,
  gcc14Stdenv,
  hyprland,
  fetchFromGitHub,
}:
gcc14Stdenv.mkDerivation (finalAttrs: {
  pname = "hyprNStack";
  version = "unstable";

  src = ./.;

  inherit (hyprland) nativeBuildInputs;

  buildInputs = [ hyprland.dev ] ++ hyprland.buildInputs;

  # Skip meson phases
  configurePhase = "true";
  mesonConfigurePhase = "true";
  mesonBuildPhase = "true";
  mesonInstallPhase = "true";

  buildPhase = /* sh */ ''
    make all
  '';

  installPhase = /* sh */ ''
    mkdir -p $out/lib
    cp nstackLayoutPlugin.so $out/lib/libhyprNStack.so
  '';

  meta = {
    homepage = "https://github.com/zakk4223/hyprNStack";
    description = "Hyprland HyprNStack Plugin";
    maintainers = [ lib.maintainers.iynaix ];
    platforms = lib.platforms.linux;
  };
})
