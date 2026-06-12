-- Lua 5.1 compatibility:
-- * math.maxinteger/math.mininteger appeared in Lua 5.3; PureScript Int
--   is a 32-bit integer, so its bounds are spelled out literally.
-- * "\u{...}" escapes appeared in Lua 5.3 (PUC Lua 5.1 silently reads
--   "\u" as "u"). A Char is a single byte in pslua, so its bounds are
--   the byte bounds.
return {
  topInt = (2147483647),
  bottomInt = (-2147483648),
  topChar = ("\255"),
  bottomChar = ("\0"),
  topNumber = (1 / 0),
  bottomNumber = (-1 / 0)
}
