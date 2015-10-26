local Wrapper = {}
local Helper = {}

local Map = {}

function Map.StringUpper(k,v)
  return v:upper()
end

function Map.StringLower(k,v)
  return v:lower()
end

function Map.StringReverse(k,v)
  return v:reverse()
end

Helper.Map = Map

Wrapper.Helper = Helper

return Wrapper
