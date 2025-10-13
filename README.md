# LeBlue [![bluebuild build badge](https://github.com/speakintelnet/leblue/actions/workflows/build.yml/badge.svg)](https://github.com/speakintelnet/leblue/actions/workflows/build.yml)

This is my take on an hyprland based atomic OS built on top on blue-build.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/speakintelnet/leblue:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/speakintelnet/leblue:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Credits

This template takes high inspiration from the followings:

- [Wayblue](https://github.com/wayblueorg/wayblue) (Hyprland and related packages)
- [Aurora](https://github.com/ublue-os/aurora) (DevOps inspiration)
- [Bazzite](https://github.com/ublue-os/bazzite/) (Gaming inspiration)
