# User-installed binaries. bash gets this from ~/.profile, which fish never
# reads, so it must be added here explicitly.
if test -d ~/.local/bin
    fish_add_path ~/.local/bin
end

# Add Cargo's bin directory to PATH when present
if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end
