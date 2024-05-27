local vide = require(script.Parent.Parent.Parent.packages.vide)
local Page = require(script.Parent.Parent.components.Page)
local images = require(script.images)

export type TherapyProps = {}

local function Therapy(props: TherapyProps): Frame
  local cubeOrientation = vide.source(90) -- Offset by 90 so when the cube spins, we don't see the back of the cube which changes the image

  local sides = {
    Enum.NormalId.Front,
    Enum.NormalId.Left,
    Enum.NormalId.Back,
    Enum.NormalId.Right,
  }

  local camera = vide.create "Camera" {
    CFrame = CFrame.new(0, 6, -25) * CFrame.Angles(.3, math.pi, 0)
  }
  local cube = vide.create "Part" {
    Size = Vector3.new(15, 15, 15),
    Orientation = vide.spring(function()
      return Vector3.new(0, cubeOrientation(), 0)
    end, 1.5, .15)
  }

  local function spawnNextImage()
    
    table.insert(sides, table.remove(sides, 1)) -- Shift the first element to the end
    
    local randomImage = images[math.random(#images)]
    local decal = cube:FindFirstChild(sides[1].Name) or vide.create "Decal" {
      Name = sides[1].Name,
      Face = sides[1],
      Parent = cube
    }
    decal.Texture = `rbxassetid://{randomImage}`
  end 


  task.spawn(function()
    for i = 1, 4 do
      spawnNextImage()
    end
    while task.wait(10) do
      cubeOrientation(cubeOrientation() - 90)
      spawnNextImage()
    end
  end)

  return Page {
    vide.create "TextButton" {
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),

      Activated = function()
        cubeOrientation(cubeOrientation() - 90)
        spawnNextImage()
      end,

      vide.create "ViewportFrame" {
        Name = "Cube",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(.5, .5),
        AnchorPoint = Vector2.new(.5, .5),
  
        CurrentCamera = camera,
  
        vide.create "UIAspectRatioConstraint" {
          AspectRatio = 1
        },

        cube,
      }
    }
  }
end

return Therapy