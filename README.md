# Hypr-Aurora [![bluebuild build badge](https://github.com/speakintelnet/hypr-aurora/actions/workflows/build.yml/badge.svg)](https://github.com/speakintelnet/hypr-aurora/actions/workflows/build.yml)

This repository has a single goal, take [Aurora from ublue](https://github.com/ublue-os/aurora) and replace plasma for [hyprland](https://github.com/hyprwm/Hyprland).

![Preview](preview.png)

To keep the spirit of Aurora, a custom SDDM theme was also created that imitate the breeze theme.

![SDDM Preview](files/system/usr/share/sddm/themes/aurora-unbreezed/preview.png)

> [!WARNING]  
> This image is experimental, I'm using it personally so it works but I don't know to which extent. I haven't tested all the ujust scripts. Try at your own discretion.

## Installation

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/speakintelnet/hypr-aurora:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/speakintelnet/hypr-aurora:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

