dofile("build/main.min.lua")
assert(_._MODULES.Core,"Core isn't loaded!")

local Testing = {}

local function equals(v,vv)
  if(type(v) ~= type(vv)) then return false end
  if(type(v) == "table") then
    for k,v in pairs(v) do
      if(vv[k] ~= v) then
        return false
      end
    end
    return true
  end
  return v==vv
end

function Testing.expect(func,v)
  local res = func()
  if(not equals(res,v)) then error("expected "..textutils.serialize(v).." got "..textutils.serialize(res)) end
end

_G.Testing = Testing

dofile("tests/test.core.lua")
if(_._MODULES.Array) then
  dofile("tests/test.array.lua")
end
if(_._MODULES.Table) then
  dofile("tests/test.table.lua")
end

_G.Testing = nil
