# Cosmic Store (Flatpak Build)

This guide walks you through building and running the **Cosmic Store** from source using Flatpak.

---

## 📦 Prerequisites

Make sure your system is up to date:

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🦀 Install Rust

Install Rust using `rustup`:

```bash
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
```

---

## 🔧 Install Dependencies

Install required system packages:

```bash
sudo apt install -y \
  git \
  flatpak \
  flatpak-builder \
  libflatpak-dev \
  libgtk-4-dev \
  libadwaita-1-dev \
  build-essential \
  pkg-config \
  libssl-dev \
  libxkbcommon-dev \
  just
```

(Optional) Install the latest version of `just` via Cargo:

```bash
cargo install just
```

---

## 📥 Clone the Repository

```bash
git clone https://github.com/pop-os/cosmic-store
cd cosmic-store
```

---

## 🚀 Build with Flatpak

Make the build script executable:

```bash
chmod +x flatpak.sh
```

Run the build:

```bash
./flatpak.sh
```

---

## ▶️ Run the App

After building, run the app with:

```bash
flatpak run com.system76.CosmicStore
```

---

## 📝 Notes

* Ensure Flatpak is set up:

  ```bash
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  ```

* If you encounter issues, try updating Rust:

  ```bash
  rustup update
  ```
