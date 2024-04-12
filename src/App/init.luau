local Selection = game:GetService("Selection")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = script.Components

local Padding = require(Components.Padding)
local Pages = require(Components.Pages)
local Theme = require(Fuse.App.Theme)

local OreValidator = require(script.Pages.OreValidator)
local CatTherapy = require(script.Pages.CatTherapy)
local SkyboxTemplates = require(script.Pages.SkyboxTemplates)

local State = require(Fuse.State)

local vide = require(Packages.vide)

local create = vide.create
local source = vide.source
local effect = vide.effect

export type AppProps = {
  state: State.State<{
    tabIndex: number
  }>
}

local function App(props: AppProps): Frame
  local ore = source(nil)
  local pageIndex = source(props.state.tabIndex)

  effect(function()
    props.state.tabIndex = pageIndex()
  end)

  local function selectionChanged()
    local firstSelected = Selection:Get()[1]
    
    if not firstSelected or typeof(firstSelected) ~= "Instance" then 
      return ore(nil)
    end

    if firstSelected:IsA("Model") then
      local primaryPart = 
        firstSelected.PrimaryPart 
        or (
          #firstSelected:GetChildren() == 1 
            and firstSelected:GetChildren()[1] 
            or nil
          )
      return ore(primaryPart)
    elseif firstSelected:IsA("BasePart") then
      return ore(firstSelected)
    else
      return ore(nil)
    end
  end

  Selection.SelectionChanged:Connect(selectionChanged)
  selectionChanged() -- initial call

  return create "Frame" {
    Name = "App",
    BackgroundColor3 = Theme "Background",
    Size = UDim2.fromScale(1, 1),

    Pages {
      ContainerLayout = {
        Padding { UDim.new(0, 8), UDim.new(0, 8) }
      },

      pageIndex = pageIndex,

      pages = {
        {
          name = "Ore Validator",
          component = OreValidator {
            ore = ore
          }
        },
        {
          name = "Skybox Templates",
          component = SkyboxTemplates {}
        },
        {
          name = "Cat Therapy",
          component = CatTherapy {}
        }
      }
    }
  }
end

return App