{ stdenv, fetchurl, meson, ninja, vala, libxslt, pkgconfig, glib, gtk3, gnome3, python3, dconf
, libxml2, gettext, docbook_xsl, wrapGAppsHook, gobject-introspection }:

let
  pname = "dconf-editor";
  version = "3.35.91";
in stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${name}.tar.xz";
    sha256 = "1y0n152aipzraddkzaxxlc9h6s5qr55ghfc40yavlvpp7q1n5z7c";
  };

  nativeBuildInputs = [
    meson ninja vala libxslt pkgconfig wrapGAppsHook
    gettext docbook_xsl libxml2 gobject-introspection python3
  ];

  buildInputs = [ glib gtk3 dconf ];

  postPatch = ''
    chmod +x meson_post_install.py
    patchShebangs meson_post_install.py
  '';

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      attrPath = "gnome3.${pname}";
    };
  };

  meta = with stdenv.lib; {
    platforms = platforms.linux;
    maintainers = gnome3.maintainers;
  };
}
