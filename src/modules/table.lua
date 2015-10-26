local Table = {}

function Table.each(t,f,...)
  for k,v in pairs(t) do
    f(k,v,...)
  end
end

function Table.at(t,...)
  local keys = {...}
  local vals = {}
  for _,v in pairs(keys) do
    vals[#vals+1] = t[v]
  end
  return vals
end

function Table.count(t,v)
  if(v == nil) then return #t end
  local i = 0
  for k,vv in pairs(t) do if(_.isEqual(v,v)) then i = i + 1 end end
  return i
end

function Table.cycle(t,n)
  n = n or 1
  if n<=0 then return function() end end
  local k, fk
  local i = 0
  while true do
    return function()
      k = k and next(t,k) or next(t)
      fk = not fk and k or fk
      if n then
        i = (k==fk) and i+1 or i
        if i > n then
          return
        end
      end
      return k, t[k]
    end
  end
end

function Table.map(t,f)
  local tt = {}
  for k,v in pairs(t) do
    tt[k] = f(k,v)
  end
  return tt
end

function Table.reduce(t,f)
  local m = ""
  for _,v in pairs(t) do
    m = f(m,v)
  end
  return m
end

function Table.mapReduce(t,f)
  local s = {}
  local m = ""
  for _,v in pairs(t) do
    m = f(m,v)
    s[#s+1] = m
  end
  return s
end

function Table.detect(t,v)

  for k,vv in pairs(t) do
    if(_.isCallable(v)) then
      if(_.isEqual(vv,v(vv))) then return k end
    else
      if(_.isEqual(v,vv)) then return k end
    end
  end
  return nil
end

function Table.all(t,f)
  for k,v in pairs(t) do
    if(not f(k,v)) then return false end
  end
  return true
end

function Table.include(t,v)
  return Table.detect(t,v) ~= nil
end

return Table
