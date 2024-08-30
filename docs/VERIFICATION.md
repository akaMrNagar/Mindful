# 🔏 Verification

APK released on Google Play and GitHub are signed using Google Play Signing. They can
be verified using
[apksigner](https://developer.android.com/studio/command-line/apksigner.html#options-verify) :

```sh
apksigner verify --print-certs --verbose mindful.apk
```

The certificate fingerprints should correspond to the ones listed below:

```sh
dn: CN=Android, OU=Android, O=Google Inc., L=Mountain View, ST=California, C=US
SHA-256 digest: BE:67:D0:87:0C:16:B4:E8:35:43:2E:03:FD:DC:D1:76:C2:86:6E:99:71:54:1F:97:97:6C:1A:01:8C:C4:0F:C8
SHA-1 digest: 46:6E:49:25:55:62:50:44:19:ED:9B:9E:C6:D8:A5:1F:D7:48:11:D1
MD5 digest: D2:D2:8F:6F:40:73:56:33:EC:D7:BD:EB:E2:0E:EC:AB
```
