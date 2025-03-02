# IMPORTANT
    Remember to mask gentoo repository's sys-auth/libfprint and
    sys-auth/fprintd package

In /etc/portage/package.mask/fprintd:
```/etc/portage/package.mask/fprintd
# My fingerprint device is Elan 04f3:0c00
# Please install sys-auth/fprintd::elanmoc2-fprintd instead
sys-auth/libfprint::gentoo
sys-auth/fprintd::gentoo
```
