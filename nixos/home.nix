# Home Manager Configuration for all devices

{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
    ];
    # Symlink files from other locations
    file = {
      #".config/alacritty" = {
      #  source = config.lib.file.mkOutOfStoreSymlink "/home/derbetakevin/Development/dotfiles/Applications/alacritty";
      #  recursive = true;
      #};
      ".config/conky" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/derbetakevin/Development/dotfiles/Applications/conky";
        recursive = true;
      };
      ".config/fastfetch" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/derbetakevin/Development/dotfiles/Applications/fastfetch";
        recursive = true;
      };
      ".config/neofetch" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/derbetakevin/Development/dotfiles/Applications/neofetch";
        recursive = true;
      };
    };
  };
}
