name="ananicy-cpp"
pkgname="ananicy"
repology=("project: ${name}")
arch=('amd64')
version="1.0.1"
epoch="1"
homepage='https://gitlab.com/${name}/${name}'
url="https://gitlab.com/${name}/${name}/-/archive/v${version}/${name}-v${version}.zip"
build_depends=("cmake" "build-essential" "g++" "libsystemd-dev")
breaks=("${name}-git" "${name}-bin")
replace=("ananicy" "ananicy-bin")
gives="ananicy"
description="Ananicy rewritten in C++ for much lower CPU and memory usage."
maintainer="vnepogodin"
provides=('ananicy')

prepare() {
    git clone https://gitlab.com/vnepogodin/std-format.git \
        "${srcdir}/external/std-format"
    git clone https://github.com/kuche1/minq-ananicy.git \
        "${srcdir}/external/minq-ananicy"
    test ! -d "${pkgdir}/etc/ananicy.d/" && sudo mkdir -pv "${pkgdir}/etc/ananicy.d/"
    sudo cp -rv "${srcdir}/external/minq-ananicy/ananicy.d" \
        "${pkgdir}/etc/ananicy.d/"
}

build() {
  sudo cmake -B build \
  -DCMAKE_RELEASE_TYPE=Release \
  -DUSE_EXTERNAL_SPDLOG=OFF \
  -DUSE_EXTERNAL_FMTLIB=OFF \
  -DENABLE_SYSTEMD=ON \
  -S .

  sudo cmake --build build --target "${name}"
}

install() {
  sudo cmake --install build --component Runtime
}

postinst() {
  sudo systemctl enable --now ananicy-cpp.service
}

removescript() {
  sudo systemctl disable --now ananicy-cpp.service
}
