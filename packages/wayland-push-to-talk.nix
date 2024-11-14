{

  stdenv,
  libevdev,
  xdotool,
  xorg,
  dbus,
  pkg-config,
  fetchgit,
}:
stdenv.mkDerivation rec {
  pname = "wayland-push-to-talk-fix";
  version = "1.0";

  src = fetchgit {
    url = "https://github.com/Rush/wayland-push-to-talk-fix";
    rev = "490f43054453871fe18e7d7e9041cfbd0f1d9b7d";
    sha256 = "sha256-ZRSgrQHnNdEF2PyaflmI5sUoKCxtZ0mQY/bb/9PH64c=";
  };
  buildInputs = [
    libevdev
    xdotool
    xorg.libX11
  ];

  nativeBuildInputs = [
    pkg-config
  ];
  #dbus = dbus;

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv push-to-talk $out/bin
  '';
}
