name="whatsapp-for-linux"
pkgname="whatsapp-for-linux"
repology=("project: ${name}")
arch=('amd64')
version="1.6.2"
epoch="1"
homepage='https://github.com/eneshecan/${name}'
url="https://github.com/eneshecan/${name}/archive/refs/tags/v${version}.zip"
build_depends=("cmake" "intltool" "libgtkmm-3.0-dev"
               "libwebkit2gtk-4.0-dev" "libayatana-appindicator3-dev"
               "libcanberra-dev")
breaks=("${name}-git" "${name}-bin")
replace=("${name}-bin" "${name}-git")
gives="whatsapp-for-linux"
description="An unofficial WhatsApp desktop application for Linux."
maintainer="eneshecan"
provides=('whatsapp-for-linux')

prepare() {
    mkdir -p build/release
}

build() {
  cd build/release
  sudo cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    ../..

  sudo make -j "$(nproc --all)"
}

install() {
  cd build/release
  sudo make install DESTDIR="${pkgdir}"
}

uninstall() {
  cd build/release
  sudo make uninstall DESTDIR="${pkgdir}"
}
