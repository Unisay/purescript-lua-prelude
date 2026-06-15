return {
  showIntImpl = (function(n) return tostring(n) end),
  showNumberImpl = (function(n)
    -- Match PureScript `show`: NaN/Infinity spellings (Lua prints inf/nan),
    -- and integral Numbers keep a trailing ".0" so they round-trip as Number.
    if n ~= n then return "NaN" end
    if n == math.huge then return "Infinity" end
    if n == -math.huge then return "-Infinity" end
    local str = tostring(n)
    if str:find("[.eE]") then return str end
    return str .. ".0"
  end),
  showCharImpl = (function(n)
    local code = n:byte()
    if code < 0x20 or code == 0x7F then
      if n == "\a" then return "'\\a'" end
      if n == "\b" then return "'\\b'" end
      if n == "\f" then return "'\\f'" end
      if n == "\n" then return "'\\n'" end
      if n == "\r" then return "'\\r'" end
      if n == "\t" then return "'\\t'" end
      if n == "\v" then return "'\\v'" end
      return "'\\" .. tostring(code) .. "'"
    end
    if n == "'" or n == "\\" then return "'\\" .. n .. "'" end
    return "'" .. n .. "'"
  end),
  showStringImpl = (function(s)
    -- Mirror PureScript's `show`: wrap in double quotes and escape control
    -- characters, '"' and '\' so the result round-trips to a String literal.
    local out = {"\""}
    local len = #s
    local i = 1
    while i <= len do
      local c = s:sub(i, i)
      local b = c:byte()
      if c == "\"" or c == "\\" then
        out[#out + 1] = "\\" .. c
      elseif b == 0x07 then
        out[#out + 1] = "\\a"
      elseif b == 0x08 then
        out[#out + 1] = "\\b"
      elseif b == 0x0C then
        out[#out + 1] = "\\f"
      elseif b == 0x0A then
        out[#out + 1] = "\\n"
      elseif b == 0x0D then
        out[#out + 1] = "\\r"
      elseif b == 0x09 then
        out[#out + 1] = "\\t"
      elseif b == 0x0B then
        out[#out + 1] = "\\v"
      elseif b < 0x20 or b == 0x7F then
        -- numeric escape; "\&" guards against a following digit being
        -- swallowed into the escape (e.g. "\27\&5" /= "\275").
        local nxt = s:sub(i + 1, i + 1)
        local gap = (nxt >= "0" and nxt <= "9") and "\\&" or ""
        out[#out + 1] = "\\" .. tostring(b) .. gap
      else
        out[#out + 1] = c
      end
      i = i + 1
    end
    out[#out + 1] = "\""
    return table.concat(out)
  end),
  showArrayImpl = (function(f)
    return function(xs)
      local l = #xs
      local ss = {}
      for i = 1, l do ss[i] = f(xs[i]) end
      return "[" .. table.concat(ss, ",") .. "]"
    end
  end)
}
