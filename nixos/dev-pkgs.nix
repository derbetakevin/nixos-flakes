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
    
    users = {
      users = {
        derbetakevin = {
          extraGroups = [ "adbusers" ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      gh
      gitFull
      github-desktop
      gnat13
      gnome.ghex
      godot_4
      nix-prefetch-scripts
      pkg-config
      powershell
      python311Full
      vscode
    ];
  };
}