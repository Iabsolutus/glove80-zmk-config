{ pkgs ? import <nixpkgs> {}
, firmware ? import ../src/default.nix { inherit pkgs; }  # => імпортуємо ZMK build функції
}:

let
  config = ./.;

  glove80_left = firmware.zmk.override {
    board  = "glove80_lh";
    keymap = "${config}/glove80.keymap";
    kconfig = "${config}/glove80.conf";
  };

  glove80_right = firmware.zmk.override {
    board  = "glove80_rh";
    keymap = "${config}/glove80.keymap";
    kconfig = "${config}/glove80.conf";
  };
in

# Деякі версії combine_uf2 приймають (left right name), інші — лише (left right).
# Якщо твій build знову впаде, спробуй варіант без name.
firmware.combine_uf2 glove80_left glove80_right "glove80"