{ name = "purescript-lua-prelude"
, dependencies = [ ] : List Text
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, backend =
    ''
    pslua \
    --foreign-path . \
    --ps-output output \
    --lua-output-file dist/Prelude.lua \
    --entry Prelude
    ''
}
