# Source hardware and system notes

The source machine reports:

- Apple `MacBookPro11,1` (13-inch Retina, mid-2014)
- Intel Core i5-4278U (Haswell, 2 cores / 4 threads)
- Intel Haswell integrated graphics
- Broadcom BCM4360 Wi-Fi
- Falcon Ridge Thunderbolt 2 controller
- Omarchy 4.0.4 with the `linux-omarchy` kernel

No serial numbers, disk UUIDs, network addresses, or encryption identifiers are
stored in this repository.

## Hardware configuration

- `facetimehd.conf` lets the FaceTime HD driver claim the camera controller.
- `hid_apple.conf` restores the expected Apple function-key mode.
- `mbpfan.conf` starts raising fan speed at 66°C and reaches maximum by 86°C.
- `thunderbolt-net.conf` and `thunderbolt_module.conf` preserve the tested
  Thunderbolt networking setup, but are optional because the current workflow
  uses Wi-Fi.

The source system also has `broadcom-wl-dkms`, `thermald`, `mbpfan-git`, and
Intel video acceleration installed. See `packages/macbook-2014.txt`.

## Fan behaviour

Hearing the fan during OBS/NDI use does not necessarily mean the fan controller
is broken. On this machine, NDI decoding can load the older dual-core CPU while
`mbpfan` deliberately begins increasing fan speed at 66°C. Opening the local web
app directly over Wi-Fi avoids NDI video decoding when only a browser view is
needed.
