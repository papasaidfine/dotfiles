# Add Cargo's bin directory to PATH when present
if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end
