{ stdenv, fetchurl, meson, ninja, pkgconfig, gettext, gnome3
, glib, gtk3, gobject-introspection, python3, ncurses
}:

stdenv.mkDerivation rec {
  pname = "libpeas";
  version = "1.25.3";

  outputs = [ "out" "dev" ];

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0fbnx5n1lfdw6p0vbwb8dxgcs27z493rdjfh3mpcsa8cfhlvp6qw";
  };

  nativeBuildInputs = [ pkgconfig meson ninja gettext gobject-introspection ];
  buildInputs =  [ glib gtk3 ncurses python3 python3.pkgs.pygobject3 ];
  propagatedBuildInputs = [
    # Required by libpeas-1.0.pc
    gobject-introspection
  ];

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    description = "A GObject-based plugins engine";
    homepage = https://wiki.gnome.org/Projects/Libpeas;
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
    maintainers = gnome3.maintainers;
  };
}
