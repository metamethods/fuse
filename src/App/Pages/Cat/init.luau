local ContentProviderService = game:GetService("ContentProvider")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children

local CAT_IMAGE_IDS = {
  16335311566,
  11104447788,
  15461907747,
  9070058749,
  15795449105,
  14841615129,
  5009915795,
  902550191,
  16452498785,
  15990218954,
  14031218942,
  16583833020,
  13575694232,
  12980052411,
  14535699113,
  16527239823,
  16172352860,
  16918241239,
  84682171,
  9378201933,
  12722339815
}

local function randomCatImage()
  return `http://www.roblox.com/asset/?id={CAT_IMAGE_IDS[math.random(#CAT_IMAGE_IDS)]}`
end

export type CatProps = {}

return function(props: CatProps)
  local imageId = Value(randomCatImage())

  task.spawn(function()
    for _, id in CAT_IMAGE_IDS do
      ContentProviderService:PreloadAsync({
        `http://www.roblox.com/asset/?id={id}`
      })
    end
  end)

  task.spawn(function()
    while task.wait(5) do
      imageId:set(randomCatImage())
    end
  end)

  return New "Frame" {
    Name = "CatTherapy",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),

    [Children] = {
      New "ImageLabel" {
        Name = "Cat",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 24, 1, 24),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),

        Image = imageId
      }
    }
  }
end