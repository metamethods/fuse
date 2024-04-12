local Lighting = game:GetService("Lighting")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local ScrollingFrame = require(Components.ScrollingFrame)
local List = require(Components.List)
local HeaderText = require(Components.HeaderText)
local ParagraphText = require(Components.ParagraphText)
local Text = require(Components.Text)
local Rounded = require(Components.Rounded)
local Padding = require(Components.Padding)
local Theme = require(Fuse.App.Theme)

local vide = require(Packages.vide)

local create = vide.create
local source = vide.source
local indexes = vide.indexes
local spring = vide.spring

export type HeaderProps = {}

local function Header(props: HeaderProps): Frame
  return List {
    Layout = {
      Size = UDim2.fromScale(1, 0),
      AutomaticSize = Enum.AutomaticSize.Y
    },

    ListLayout = {
      Padding = UDim.new(0, 8)
    },

    Children = {
      HeaderText { Text = "Skybox Templates" },
      ParagraphText { Text = "Choose one of the skyboxes listed below, and watch your game's skybox change instantly!" }
    }
  }
end

export type SkyboxProps = {
  skybox: Sky
}

local function Skybox(props: SkyboxProps): ImageButton
  local hovering = source(false)
  local pressed = source(false)

  local overlayTransparency = function()
    return (hovering() and not pressed())
      and .5 or 1
  end

  return create "ImageButton" {
    Name = "Skybox",
    BackgroundColor3 = Theme "BackgroundSecondary",
    Size = UDim2.new(1, 0, 0, 200),

    Image = props.skybox.SkyboxBk,

    MouseEnter = function()
      hovering(true)
    end,

    MouseLeave = function()
      hovering(false)
      pressed(false)
    end,

    MouseButton1Down = function()
      pressed(true)
    end,

    MouseButton1Up = function()
      pressed(false)
    end,

    Activated = function()
      -- i was a lil too lazy to make a if statement n stuff
      (Lighting:FindFirstChildOfClass("Sky") or {Destroy = function() end}):Destroy()
      props.skybox:Clone().Parent = Lighting
    end,

    Rounded {},
    Padding { UDim.new(0, 8) },
    Text {
      Size = UDim2.fromScale(1, .2),
      BackgroundColor3 = Theme "BackgroundTertiary",
      BackgroundTransparency = .5,
      Position = UDim2.fromScale(0, 1),
      AnchorPoint = Vector2.new(0, 1),

      Text = props.skybox.Name,

      ZIndex = 2,

      Rounded {}
    },

    create "Frame" {
      Name = "Overlay",
      Size = UDim2.new(1, 16, 1, 16),
      Position = UDim2.fromScale(.5, .5),
      AnchorPoint = Vector2.new(.5, .5),
      BackgroundColor3 = Theme "Overlay",
      BackgroundTransparency = spring(overlayTransparency, .15, 1),

      Rounded {}
    }
  }
end

export type Props = {}

local function SkyboxTemplates(props: Props): ScrollingFrame
  return ScrollingFrame {
    Size = UDim2.fromScale(1, 1),
    
    List {
      Layout = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y
      },

      ListLayout = {
        Padding = UDim.new(0, 8),
      },

      Children = {
        Header {},
        indexes(source(script.Templates:GetChildren()), function(skybox: () -> Sky, i)
          return Skybox {
            skybox = skybox()
          }
        end)
      }
    }
  }
end

return SkyboxTemplates