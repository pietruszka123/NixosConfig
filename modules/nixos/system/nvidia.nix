{ lib, config, ... }:

{
  options = {
    systemModule.nvidia = {
      enable = lib.mkEnableOption "enable nvidia module";

      nvidia_prime = lib.mkOption {
        default = "sync";
        description = "nvidia prime mode";
      };
      nvidiaBusId = lib.mkOption { description = "nvidia pci bus"; };
      intelBusId = lib.mkOption {
        default = "";
        description = "intel pci bus";
      };
      amdBusId = lib.mkOption {
        default = "";
        description = "amd pci bus";
      };
    };
  };

  config = lib.mkIf config.systemModule.nvidia.enable {
    nixpkgs.config.allowUnfree = true;

    services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.

    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        prime =
          (
            if config.systemModule.nvidia.nvidia_prime == "sync" then
              {
                sync.enable = true;
              }
            else if config.systemModule.nvidia.nvidia_prime == "offload" then
              {
                offload.enable = lib.mkForce true;
                offload.enableOffloadCmd = lib.mkForce true;
              }
            else
              { }
          )
          // {
            nvidiaBusId = config.systemModule.nvidia.nvidiaBusId;
            intelBusId = config.systemModule.nvidia.intelBusId;
            amdgpuBusId = config.systemModule.nvidia.amdBusId;
          };

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = true;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        # package = config.boot.kernelPackages.nvidiaPackages.beta;

      };
    };
  };
}
