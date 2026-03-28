#!/bin/bash

echo "Building cosmic-store binary..."
cargo build --release

echo "Collecting libraries..."
rm -rf lib && mkdir lib

ldd target/release/cosmic-store | awk '{print $3}' | grep '^/' | \
    grep -v 'libc\|libm\|libdl\|libpthread\|ld-linux\|libgcc\|libstdc\|libresolv' | \
    while read lib; do
        real_lib=$(readlink -f "$lib" 2>/dev/null || echo "$lib")
        cp "$real_lib" lib/ 2>/dev/null
        ln -sf "$(basename "$real_lib")" "lib/$(basename "$lib")" 2>/dev/null
    done

echo "Adding libcurl-gnutls..."
rm -f lib/libcurl-gnutls.so.4
cp /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4.8.0 lib/
ln -sf libcurl-gnutls.so.4.8.0 lib/libcurl-gnutls.so.4

echo "Adding libmalcontent..."
rm -f lib/libmalcontent-0.so.0
cp /usr/lib/x86_64-linux-gnu/libmalcontent-0.so.0.11.1 lib/
ln -sf libmalcontent-0.so.0.11.1 lib/libmalcontent-0.so.0

echo "Adding libflatpak..."
rm -f lib/libflatpak.so.0 lib/libflatpak.so
cp /usr/lib/x86_64-linux-gnu/libflatpak.so.0.11406.0 lib/
ln -sf libflatpak.so.0.11406.0 lib/libflatpak.so.0
ln -sf libflatpak.so.0 lib/libflatpak.so

echo "Adding libdconf..."
rm -f lib/libdconf.so.1
cp /usr/lib/x86_64-linux-gnu/libdconf.so.1.0.0 lib/
ln -sf libdconf.so.1.0.0 lib/libdconf.so.1

echo "Fixing problematic libraries..."
cp /usr/lib/x86_64-linux-gnu/librtmp.so.1 lib/
cp /usr/lib/x86_64-linux-gnu/libselinux.so.1 lib/
cp /usr/lib/x86_64-linux-gnu/libssl.so.3 lib/

echo "Building Flatpak..."
flatpak-builder --user --install-deps-from=flathub --force-clean build-dir com.system76.CosmicStore.json
flatpak build-export repo build-dir
flatpak build-bundle repo cosmic-store.flatpak com.system76.CosmicStore

echo "Done! Bundle created: cosmic-store.flatpak"
