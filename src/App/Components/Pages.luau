local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local ListSelection = require(Components.ListSelection)

local vide = require(Packages.vide)

local create = vide.create
local source = vide.source
local switch = vide.switch

export type PagesProps = {
  ContainerLayout: vide.vFrame?,

  pageIndex: () -> number,

  pages: {{
    name: string,
    component: Instance
  }}
}

local function Pages(props: PagesProps): Frame
  local pageComponents = {}

  local items = source({})

  for i, page in ipairs(props.pages) do
    table.insert(items(), page.name)
    pageComponents[i] = function() 
      return page.component
    end
  end

  return create "Frame" {
    Name = "Pages",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,

    ListSelection {
      Layout = {
        ZIndex = 2
      },

      items = items,
      selected = props.pageIndex
    },

    create "Frame" {
      Name = "PageContainer",
      Size = UDim2.new(1, 0, 1, -50),
      Position = UDim2.new(0, 0, 0, 50),
      BackgroundTransparency = 1,

      props.ContainerLayout,

      switch(props.pageIndex)(pageComponents)
    }
  }
end

return Pages