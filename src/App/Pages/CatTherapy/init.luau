local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local images = require(script.images)
local vide = require(Packages.vide)

local create = vide.create
local source = vide.source
local spring = vide.spring

export type Props = {}

local function CatTherapy(props: Props): ScrollingFrame
  local rotations = source(0)

  local cubeOrientation = function()
    return Vector3.new(0, -rotations() * 90, 0)
  end

  local cube = create "Part" {
    Name = "Thy Cube",
    Anchored = true,
    Size = Vector3.new(15, 15, 15),
    Orientation = spring(cubeOrientation, 1.5, .15)
  }

  task.spawn(function()
    local sides = {
      Enum.NormalId.Back,
      Enum.NormalId.Right,
      Enum.NormalId.Front,
      Enum.NormalId.Left,
    }
    
    local function shiftSides()
      local first = table.remove(sides, 1)
      table.insert(sides, first)
    end

    local function addImage()
      local side = sides[1]
      local image = images[math.random(#images)]

      for _, decal in cube:GetChildren() do
        if decal:IsA("Decal") and decal.Face == sides[2] then
          decal:Destroy()
        end
      end

      create "Decal" {
        Texture = `http://www.roblox.com/asset/?id={image}`,
        Face = side,
        Parent = cube
      }

      shiftSides()
    end

    addImage()
    addImage()

    while task.wait(10) do
      addImage()
      rotations(rotations() + 1)
    end
  end)

  return create "Frame" {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),

    create "ViewportFrame" {
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),
      Position = UDim2.fromScale(.5, .5),
      AnchorPoint = Vector2.new(.5, .5),

      LightColor = Color3.new(1, 1, 1),
      Ambient = Color3.new(.5, .5, .5),

      CurrentCamera = create "Camera" {
        CFrame = CFrame.lookAt(Vector3.new(0, 6, 25), Vector3.new(0, 0, 0))
      },

      cube,

      create "UIAspectRatioConstraint" {
        AspectRatio = 1
      }
    }
  }
end

return CatTherapy