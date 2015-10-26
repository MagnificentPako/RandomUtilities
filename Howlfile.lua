do --Options

  Options:Option "array"
    :Description "Add the 'array' module"
    :Alias "a"

  Options:Option "table"
    :Description "Add the 'table' module"
    :Alias "b" -- using "b" because "t" is --time already.

  Options:Option "computercraft"
    :Description "Add the 'computercraft' module"
    :Alias "c"

  Options:Option "helper"
    :Description "Add the 'helper' module"
    :Alias "h"
end

sources = Dependencies(CurrentDirectory)

sources:Main "src/main.lua"
  :Depends "Module.Core"

sources:File "src/modules/core.lua"
  :Name "Core"
  :Alias "Module.Core"

do --Modules
  sources:File "src/modules/table.lua"
    :Name "Table"
    :Alias "Module.Table"

  sources:File "src/modules/array.lua"
    :Name "Array"
    :Alias "Module.Array"

  sources:File "src/modules/computercraft.lua"
    :Name "CC"
    :Alias "Module.CC"

  sources:File "src/modules/helper.lua"
    :Name "Helper"
    :Alias "Module.Helper"
end

do --Option Parsing
  if Options:Get("table") then
    sources:Depends "Module.Table"
  end

  if Options:Get("array") then
    sources:Depends "Module.Array"
  end

  if Options:Get("computercraft") then
    sources:Depends "Module.CC"
  end

  if Options:Get("helper") then
    sources:Depends "Module.Helper"
  end

end

do --Tasks
  Tasks:Clean("clean","build")
  Tasks:Combine("combine",sources,"build/main.lua",{"clean"}):Verify(true)

  Tasks:Minify("minify","build/main.lua","build/main.min.lua")

  -- TODO: Add all the tests needed. To bored right now.
  --[[Tasks:Task "test"(function()
    dofile("tests/test.lua")
  end)
    :Requires "build/main.min.lua"
    ]]

  Tasks:Task "run"(function()
    dofile("build/main.min.lua")
  end)

  Tasks:Task "build"{"minify","run"}
    :Description "Minify and run"
end
