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
chmod +x flatpak.sh
<br>
