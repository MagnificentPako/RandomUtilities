local _ = {}
_G._ = setmetatable({},{__index=_})
local function merge(t,tt)
  if(not t) then return end
  for k,v in pairs(t) do
    if(not tt[k]) then tt[k] = v end
  end
end

merge(Core,_)
merge(Array,_)
merge(Table,_)
merge(Helper,_)

_._MODULES = {}
_._MODULES.Core = true
_._MODULES.Array = _.toBoolean(Array)
_._MODULES.Table = _.toBoolean(Table)
_._MODULES.Computercraft = _.toBoolean(CC)
_._MODULES.Helper = _.toBoolean(Helper)

function _.new(v)
  local i = {_value=v,_wrapped=true}
  local function chainindex(t,k)
    if(k == "value") then return function() return i._value end end
    if(_.isCallable(_[k])) then
      return function(...)
        return _.new(_[k](i._value,...))
      end
    end
  end
  return setmetatable(i,{__index = chainindex})
end

function _.chain(v)
  return _.new(v)
end
