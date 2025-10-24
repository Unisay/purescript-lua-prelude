return {
  concatString = (function(s1) return function(s2) return s1 .. s2 end end),
  concatArray = (function(xs)
    return function(ys)
      if #xs == 0 then return ys end
      if #ys == 0 then return xs end
      local result = {}
      for index, value in ipairs(xs) do
        result[index] = value
      end
      local offset = #result
      for index, value in ipairs(ys) do
        result[index + offset] = value
      end
      return result
    end
  end)
}
