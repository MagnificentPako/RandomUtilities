-- _.identity
Testing.expect(function()
  return _.identity("test")
end,"test")

-- _.toBoolean
Testing.expect(function()
  return _.toBoolean("test")
end,true)

Testing.expect(function()
  return _.toBoolean(nil)
end,false)

-- _.functions
Testing.expect(function()
  return _.functions(coroutine)
end,{"resume","create","wrap","status","running","yield"})

-- _.clone
Testing.expect(function()
  return _.clone({1,2,3})
end,{1,2,3})

-- _.isCallable
Testing.expect(function()
  return _.isCallable(print)
end,true)

Testing.expect(function()
  return _.isCallable(setmetatable({},{__call=function() return end}))
end,true)

Testing.expect(function()
  return _.isCallable(setmetatable({},{__index = string}).upper)
end,true)
