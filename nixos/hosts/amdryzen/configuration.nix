# amdryzen specific config
{ config, pkgs, inputs, ... }: {
  
  # Imports specific
  imports = [
    ../../dev-pkgs.nix
    ../../gaming.nix
    ../../kde.nix
  ];

  # Bootloader has to be done per machine, since the ThinkPad doesn't 
  # support UEFI.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
  };

  # Hostname, networking and bluetooth
  networking = {
    # Specify hostname
    hostName = "AMDNix2312-X";
  };
  
  # Hardware specific
  hardware = {
    bluetooth = {
      enable = true;
    };
  };

  # Services are good. Services are great. We should use them!
  services = {
    
    # Enable printing service via CUPS
    printing = {
      enable = true;
      # Add drivers for Epson WF-7710 printer support
      drivers = with pkgs; [
        epson-escpr2
      ];
    };

    # Add JACK support to PipeWire
    pipewire = {
      jack.enable = false;
    };

    udev = {
      # Add Streamdeck MK.2 udev rule
      extraRules = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0fd9", GROUP="users", TAG+="uaccess"
      '';
    };

    spice-vdagentd = {
      enable = true;
    };

    spice-autorandr = {
      enable = true;
    };

    spice-webdavd = {
      enable = true;
    };
  };

  # QEMU/KVM & Podman
  virtualisation = {
    
    # QEMU/KVM via libvirt daemon
    libvirtd = {
      enable = true;
      
      # Extra QEMU options
      qemu = {
	      runAsRoot = true;

        swtpm = {
          enable = true;
        };

	      ovmf = {
          enable = true;
          packages = [pkgs.OVMFFull.fd];
        };
      };

      # Specify behavior on boot and shutdown
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    # Podman for containers
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
    
    # Waydroid
    waydroid = {
      enable = true;
    };
  };

  # Enable Fish-Shell
  programs.fish.enable = true;

  # User account related things specific
  users = {
    users = {
      derbetakevin = {
        extraGroups = ["libvirt" "kvm"];
        shell = pkgs.fish;
      };
    };

    groups = {
      libvirtd = {
        members = ["root" "derbetakevin"];
      };
    };
  };

  # Environment related things specific
  environment = {
    
    # Environment variables
    sessionVariables = {
      LIBVIRT_DEFAULT_URI = ["qemu:///system"];
    };

    # Packages specific
    systemPackages = with pkgs; [
      inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
      inputs.nix-software-center.packages.${system}.nix-software-center
      ausweisapp
      blueman
      chatterino2
      distrobox
      element-desktop
      espanso-wayland
      fluent-reader
      gimp
      google-chrome
      inkscape
      kdenlive
      mcfly
      microsoft-edge
      nvtop
      obs-studio
      onedrivegui
      radeontop
      skypeforlinux
      teamspeak_client
      teamspeak5_client
      virt-manager
      win-virtio
    ];
  };
}
