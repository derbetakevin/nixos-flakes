# amdryzen specific config
{
  config, 
  pkgs, 
  ...
}: {
  
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
    hostName = "AMDRyzen-Nix-2310-1";
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
  };

  # QEMU/KVM & Podman
  virtualisation = {
    
    # QEMU/KVM via libvirt daemon
    libvirtd = {
      enable = true;
      
      # Extra QEMU options
      qemu = {
        swtpm.enable = true;
	      ovmf = {
            enable = true;
            packages = with pkgs; [OVMFFull];
          };
	      runAsRoot = true;
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

  # User account related things specific
  users = {
    users = {
      derbetakevin = {
        extraGroups = ["libvirt" "kvm"];
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
      distrobox
      gimp
      inkscape
      nvtop
      virt-manager
      win-virtio
    ];
  };
}
