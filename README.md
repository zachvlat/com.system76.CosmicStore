# com.system76.CosmicStore
Flatpak build of the Cosmic Store

sudo apt update && sudo apt upgrade -y
<br>
curl https://sh.rustup.rs -sSf | sh -s -- -y
<br>
source $HOME/.cargo/env
<br>
sudo apt install -y git flatpak flatpak-builder libflatpak-dev libgtk-4-dev libadwaita-1-dev build-essential pkg-config libssl-dev libxkbcommon-dev just
<br>
cargo install just
<br>
git clone https://github.com/pop-os/cosmic-store
<br>
cd cosmic-store
<br>
cargo build --release
<br>
ldd target/release/cosmic-store | awk '{print $3}' | grep '^/' | \
    grep -v 'libc\|libm\|libdl\|libpthread\|ld-linux\|libgcc\|libstdc\|libresolv' | \
    xargs -I{} cp {} lib/
<br>
flatpak-builder --user --install-deps-from=flathub --force-clean build-dir com.system76.CosmicStore.json
<br>
flatpak build-export repo build-dir
<br>
flatpak build-bundle repo cosmic-store-new.flatpak com.system76.CosmicStore
<br>

* In order to show the application on the first just run build you have to copy the src/backend into the project. It fixes the flatpak.rs file.
