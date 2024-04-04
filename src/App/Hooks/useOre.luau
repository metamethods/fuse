local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Hooks = App.Hooks

local Fusion = require(Packages.fusion)
local useSelection = require(Hooks.useSelection)

local Value = Fusion.Value

-- Gotta say, pretty scuffed lmao
-- TODO: Refactor this (somehow)
return function(): Fusion.Value<BasePart?>
  local ore = Value()

  useSelection(function(selection)
    local function getOre(): BasePart?
      local object = selection[1]
      if not object or typeof(object) ~= "Instance" then return end
      if not object:IsA("BasePart") and not object:IsA("Model") and not object:IsA("MeshPart") then return end
      
      if object:IsA("Model") then
        if object.PrimaryPart and (object.PrimaryPart:IsA("MeshPart") or object.PrimaryPart:IsA("BasePart")) then return object.PrimaryPart end 
        local children = object:GetChildren()
        if #children == 1 and children[1]:IsA("BasePart") then return children[1] end
        return
      end

      return object
    end

    ore:set(getOre())
  end)

  return ore
end