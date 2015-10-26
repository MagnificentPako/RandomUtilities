local Core = {}

function Core.identity(o)
  return o
end

function Core.isEqual(v,vv)
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

function Core.toBoolean(v)
  return v and true or false
end

function Core.isCallable(v)
  if(type(v) == "table") then
    return type(getmetatable(v).__call) == "function"
  end
  return type(v) == "function"
end

function Core.isTable(v)
  return type(v) == "table"
end

function Core.isNil(v)
  return v == nil
end

function Core.isArray(v)
  if not Core.isTable(v) then return false end
  local i = 0
  for _,_ in pairs(v) do
    i = i + 1
    if Core.isNil(v[i]) then return false end
  end
  return true
end

function Core.isIterable(v)
  return Core.toBoolean(pcall(pairs,v))
end

function Core.isString(v)
  return type(v) == "string"
end

function Core.isEmpty(v)
  if Core.isNil(v) then return true end
  if Core.isString(v) then return #v == 0 end
  if Core.isTable(v) then return next(v) == nil end
  return true
end

function Core.isNumber(v)
  return type(v) == "number"
end

function Core.isNaN(v)
  return Core.isNumber(v) and v ~= v
end

function Core.isFinite(v)
  if not Core.isNumber(v) then return false end
  return v > -math.huge and v < math.huge
end

function Core.isBoolean(v)
  return type(v) == "boolean"
end

function Core.isInteger(v)
  return type(v) == "number" and math.floor(v) == v
end

function Core.once(f)
  local ran = false
  local res = false
  return function(...)
    if(ran) then return res end
    res = f(unpack({...}))
    return res
  end
end

function Core.functions(obj)
  local methods = {}
  for k,v in pairs(obj) do
    if(type(v) == "function") then
      table.insert(methods,k)
    end
  end
  return methods
end

function Core.clone(obj)
  if(type(obj) ~= "table") then return obj end
  local t = {}
  for k,v in pairs(obj) do
    t[Core.clone(k)] = Core.clone(v)
  end
  return t
end

function Core.result(obj,method,...)
  if(obj[method]) then
    if(Core.isCallable(obj[method])) then
      return obj[method](obj,...)
    else
      return obj[method]
    end
  elseif _.isCallable(method) then
    return method(obj,...)
  end
end

function Core.memoize(f,hash)
  local h = hash or Core.identity
  local mem = {}
  return function(...)
    for k,v in pairs(mem) do
      if(Core.isEqual(k,{...})) then return v end
    end
    local res = f(...)
    mem[{...}] = res
    return res
  end
end

function Core.after(f,count)
  local i,l = 0,count
  return function(...)
    i = i + 1
    if(i>=l) then return f(...) end
  end
end

function Core.compose(...)
  local functions = {...}
  return function(...)
    local ret = functions[1](...)
    for k,v in pairs(functions) do
      if(k~=1) then ret = v(ret) end
    end
    return ret
  end
end

function Core.pipe(value,...)
  return Core.compose(...)(value)
end

function Core.times(n,f,...)
  local res = {}
  for i = 1,n do
    res[i] = f(i,...)
  end
  return res
end

function Core.bind(f,v)
  return function(...)
    return f(v,...)
  end
end

function Core.bindn(f,...)
  local args = {...}
  return function(...)
    return f(unpack(args),...)
  end
end

function Core.tap(val,f,...)
  f(val,...)
  return val
end

return Core
