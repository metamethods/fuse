local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes

local DescribableObject = require(Classes.DescribableObject)

local SCRIPT_LIMIT = 1

return DescribableObject.new()
  :setName("Script Counter")
  :setDescription(`Checks if theres at least {SCRIPT_LIMIT} scripts or less.`)
  :setObject(function(ore: BasePart)
    local scriptCount = 0
    for _, instance in ore:GetDescendants() do
      if instance:IsA("Script") then scriptCount += 1 end
    end

    if scriptCount > SCRIPT_LIMIT then return false, `There are {scriptCount} scripts in your ore. Though you can have more than 1 script, it is recommended to keep it as 1` end
    return true, `There are {scriptCount} scripts in your ore. This is within the limit of {SCRIPT_LIMIT} scripts.`
  end)