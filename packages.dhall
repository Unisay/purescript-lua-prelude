let upstream-ps =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.15-20240320/packages.dhall
        sha256:ae8a25645e81ff979beb397a21e5d272fae7c9ebdb021a96b1b431388c8f3c34

let upstream-lua =
      https://github.com/Unisay/purescript-lua-package-sets/releases/download/psc-0.15.15-20240416/packages.dhall
        sha256:e68b7752ca4dee0f0578a2e40159caf6d1290a711777931b20d10d807823b52d

in  upstream-ps // upstream-lua
