local Array = {}

function Array.toArray(...)
  return {...}
end

function Array.find(a,v,n)
  for i = (n or 1),#a do
    if(a[i] == v) then return i end
  end
end

function Array.reverse(a)
  local aa = {}
  for i = #a,1,-1 do
    aa[#a-i+1] = a[i]
  end
  return aa
end

function Array.selectWhile(a,f,...)
  local selected = {}
  for i = 1,#a do
    if(f(i,a[i],...)) then selected[#selected+1] = a[i] else break end
  end
  return selected
end

function Array.dropWhile(a,f,...)
  local selected = {}
  for i = 1,#a do
    if(not f(i,a[i],...)) then select[#selected+1] = a[i] else break end
  end
  return selected
end

function Array.indexOf(a,v)
  for i,_v in pairs(a) do
    if(v==_v) then return i end
  end
end

function Array.lastIndexOf(a,v)
  local ind
  for i,_v in pairs(a) do
    if(v==_v) then ind = i end
  end
  return ind
end

function Array.push(a,...)
  for _,v in pairs({...}) do
    a[#a+1] = v
  end
  return a
end

function Array.pop(a)
  local r = a[1]
  table.remove(a,1)
  return r
end

function Array.unshift(a)
  local r = a[#a]
  table.remove(a,#a)
  return r
end

function Array.pull(a,...)
  local l = {} for _,v in pairs({...}) do l[v] = true end
  local aa = {}
  for _,v in pairs(a) do
    if(not l[v]) then aa[#aa+1] = v end
  end
  return aa
end

function Array.removeRange(a,s,f)
  for i = s,f do
    table.remove(a,s)
  end
  return a
end

function Array.slice(a,s,f)
  local aa = {}
  for i = s,f do
    aa[#aa+1] = a[i]
  end
  return aa
end

function Array.first(a,n)
  local aa = {}
  for i = 1,(n or 1) do
    aa[i] = a[i]
  end
  return aa
end

function Array.initial(a,n)
  local aa = {}
  for i = 1,#a-(n or 1) do
    aa[i] = a[i]
  end
  return aa
end

function Array.last(a,n)
  local aa = {}
  for i = #a-(n or 1),#a do
    aa[#aa+1] = a[i]
  end
  return aa
end

function Array.nth(a,i)
  return a[i]
end

function Array.difference(a,aa)
  local aaa = {}
  local l = {} for _,v in pairs(aa) do l[v] = true end
  for _,v in pairs(a) do if(not l[v]) then aaa[#aaa+1] = v end end
  return aaa
end

function Array.union(...)
  local a = {}
  local l = {}
  for _,_a in pairs({...}) do
    for _,e in pairs(_a) do
      if(not l[e]) then
        a[#a+1] = e
        l[e] = true
      end
    end
  end
  return
end

function Array.unique(a)
  local l = {}
  local aa = {}
  for _,v in pairs(a) do
    if(not l[v]) then
      aa[#aa+1] = v
      l[v] = true
    end
  end
  return aa
end

function Array.isunique(a)
  local l = {}
  local aa = {}
  for _,v in pairs(a) do
    if(not l[v]) then
      l[v] = true
    else
      return false
    end
  end
  return true
end

function Array.append(a,o)
  local aa = a
  for k,v in pairs(o) do
    aa[#aa+o] = v
  end
  return aa
end

function Array.range(s,f,i)
  local i = i or 1
  local a = {}
  if(not f) then
    for j = 0,s,i do
      a[#a+1] = j
    end
  else
    for j = s,f,i do
      a[#a+1] = j
    end
  end
  return a
end

function Array.rep(v,n)
  local a = {}
  for i = 1,n do
    a[#a+1] = v
  end
  return a
end

function Array.concat(v,g)
  local s = ""
  local g = g or ""
  for k,v in ipairs(v) do
    s = s..g..v
  end
  return s
end

function Array.split(v,p)
  local p = p or " "
  local t = {}
  for m in v:gmatch("[^"..p.."]+") do
    table.insert(t,m)
  end
  return t
end

return Array
