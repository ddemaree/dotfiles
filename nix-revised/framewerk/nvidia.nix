{ lib, ... }:

{
  # Many NVIDIA settings are inherited from the nixos-hardware flake for the Framework 16, loaded in ./configuration.nix. This file just covers local overrides to those settings.

  # Enable access to nvidia from containers (Docker, Podman)
  hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia = {

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Modesetting is required
    modesetting.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Dynamic Boost. It is a technology found in NVIDIA Max-Q design laptops with RTX GPUs.
    # It intelligently and automatically shifts power between
    # the CPU and GPU in real-time based on the workload of your game or application.
    dynamicBoost.enable = lib.mkForce true;

    # Nvidia Optimus PRIME: optimizes power consumption and performance of laptops equipped with Nvidia discrete GPUs, by switching between iGPU/dGPU based on workload
    prime = {
      # The framework16 flake happens to have the right values here, but uncomment and fix if necessary
      # amdgpuBusId = "PCI:195:0:0";
      # nvidiaBusId = "PCI:194:0:0";
    };
  };

  # NixOS specialization named 'nvidia-sync'. Provides the ability
  # to switch the Nvidia Optimus Prime profile
  # to sync mode during the boot process, enhancing performance.
  specialisation = {
    nvidia-sync.configuration = {
      system.nixos.tags = [ "nvidia-sync" ];
      hardware.nvidia = {
        powerManagement.finegrained = lib.mkForce false;

        prime.offload.enable = lib.mkForce false;
        prime.offload.enableOffloadCmd = lib.mkForce false;

        prime.sync.enable = lib.mkForce true;
      };
    };
  };
}
