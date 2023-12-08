{ config, pkgs, ... }: {

  config = {
    # Steam has it's issues
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    # Gaming-specific packages
    environment.systemPackages = with pkgs; [
      bottles
      cartridges
      dolphin-emu
      gamemode
      lutris
      mangohud
      minecraft
      osu-lazer-bin
      pcsx2
      retroarchFull
      retroarch-joypad-autoconfig
      superTuxKart
      winePackages.stableFull
    ];
  };
}