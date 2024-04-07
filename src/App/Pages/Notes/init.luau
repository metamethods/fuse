local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local Constants = require(Fuse.Constants)
local PrimaryButton = require(Components.PrimaryButton)
local ListLayout = require(Components.ListLayout)
local HeaderText = require(Components.HeaderText)
local Text = require(Components.Text)
local TextBox = require(Components.TextBox)

local New = Fusion.New
local Computed = Fusion.Computed
local Value = Fusion.Value
local Observer = Fusion.Observer
local ForPairs = Fusion.ForPairs
local Children = Fusion.Children

export type HeaderProps = {
  ore: Fusion.Value<BasePart?>
}

function Header(props: HeaderProps)
  return New "Frame" {
    Name = "Header",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),
      
      HeaderText "Welcome to the Notes Panel" {},
      Text "This is where you can set the title, version, or add notes to the ore that you are currently working on!" {},
      Text "" {
        Text = Computed(function()
          local ore = props.ore:get()
          return ore
            and `Selected Ore: {ore:GetFullName()}`
            or "No ore selected"
        end),
        FontFace = Font.fromEnum(Enum.Font.GothamBlack)
      }
    }
  }
end

export type ActionsProps = {
  ore: Fusion.Value<BasePart?>,

  save: () -> ()
}

function Actions(props: ActionsProps)
  return New "Frame" {
    Name = "Actions",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Horizontal, UDim.new(0, 8)),

      PrimaryButton {
        text = "Save Notes",
        disabled = Computed(function()
          return not props.ore:get()
        end),
        onClicked = props.save
      }
    }
  }
end

-- Gotta rename this to something else later
export type NotesProps_ = {
  title: Fusion.Value<string>,
  description: Fusion.Value<string>,
  version: Fusion.Value<string>,
  notes: Fusion.Value<string>
}

function Notes(props: NotesProps_)
  local NOTES = {
    {
      title = "Ore Title",
      description = "The title of the ore",
      value = props.title
    },
    {
      title = "Description",
      description = "A brief description of the ore",
      value = props.description
    },
    {
      title = "Version",
      description = "The version of the ore",
      value = props.version
    },
    {
      title = "Notes",
      description = "Any additional notes about the ore",
      value = props.notes
    }
  }

  return New "Frame" {
    Name = "Notes",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),

      ForPairs(NOTES, function(i, noteData)
        return i, {
          HeaderText "" { Text = noteData.title },
          TextBox {
            text = noteData.value,
            placeholder = noteData.description
          }
        }
      end, Fusion.cleanup)
    }
  }
end

export type NotesProps = {
  ore: Fusion.Value<BasePart?>
}

return function(props: NotesProps)
  local title = Value("")
  local description = Value("")
  local version = Value("")
  local notes = Value("")

  local observer = Observer(props.ore)

  observer:onChange(function()
    local ore = props.ore:get()
    ore = ore or game

    title:set(ore:GetAttribute(Constants.ORE_TITLE) or "")
    description:set(ore:GetAttribute(Constants.ORE_DESCRIPTION) or "")
    version:set(ore:GetAttribute(Constants.ORE_VERSION) or "")
    notes:set(ore:GetAttribute(Constants.ORE_NOTES) or "")
  end)
  observer:update()

  local function save()
    local ore = props.ore:get()
    assert(ore)

    ore:SetAttribute(Constants.ORE_TITLE, title:get())
    ore:SetAttribute(Constants.ORE_DESCRIPTION, description:get())
    ore:SetAttribute(Constants.ORE_VERSION, version:get())
    ore:SetAttribute(Constants.ORE_NOTES, notes:get())
  end

  return New "ScrollingFrame" {
    Name = "Notes",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(1, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ScrollBarThickness = 0,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),

      Header { ore = props.ore },
      Notes {
        title = title,
        description = description,
        version = version,
        notes = notes
      },
      Actions {
        ore = props.ore,
        save = save
      },
    }
  }
end