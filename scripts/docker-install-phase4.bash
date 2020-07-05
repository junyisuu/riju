#!/usr/bin/env bash

set -e
set -o pipefail
set -x

# Needed for project infrastructure
npm config set unsafe-perm true
PERL_MM_USE_DEFAULT=1 cpan App::cpanminus
rm -rf /tmp/cpan_install_*.txt

export CARGO_HOME=/opt/rust
export RUSTUP_HOME=/opt/rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

tee /opt/rust/wrapper >/dev/null <<"EOF"
#!/usr/bin/env bash
RUSTUP_HOME=/opt/rust exec /opt/rust/bin/${0##*/} "$@"
EOF
chmod +x /opt/rust/wrapper
for file in /opt/rust/bin/*; do
    ln -s /opt/rust/wrapper /usr/bin/${file##*/}
done

# Befunge
npm install -g befunge93 prompt-sync

# ClojureScript
npm install -g lumo-cljs

# CoffeeScript
npm install -g coffeescript

# Elm
npm install -g @kachkaev/run-elm

# Perl
cpanm -n Devel::REPL

# ReasonML
npm install -g bs-platform

# Rust
rustup component add rls rust-analysis rust-src

# Shakespeare
pip3 install shakespearelang

# TypeScript
npm install -g ts-node typescript

# Whitespace
pip3 install whitespace

# Wolfram Language
python3.7 -m pip install mathics

rm -f /tmp/core-js-banners

rm "$0"