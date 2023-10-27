{ config, pkgs, ... }: {

  config = {
    
    programs = {
      adb = {
        enable = true;
      };

      direnv = {
        enable = true;
        
        nix-direnv = {
          enable = true;
        };
      };
    };
    
    users.users = {
      derbetakevin = {
        extraGroups = [ "adbusers" ];
      };
    };

    environment.systemPackages = with pkgs; [
      gh
      gitFull
      gnat13
      gnome.ghex
      godot_4
      nix-prefetch-scripts
      pkg-config
      python311Full
      vscode
    ];
  };
}