local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local TabSelector = require(Components.TabSelector)

local New = Fusion.New
local ForPairs = Fusion.ForPairs
local Computed = Fusion.Computed
local Children = Fusion.Children

export type Page = {
  title: string,
  order: number,
  component: Instance
}

export type PagesProps = {
  pages: {Page},
  layout: ({Instance} | Instance)?, -- Instance(s) that will be inserted into all of the pages
  pageIndex: Fusion.Value<number>,

  size: UDim2?,
  offset: number?,
}

return function(props: PagesProps)
  local tabs: {TabSelector.Tab} = {}
  
  for _, page in ipairs(props.pages) do
    (page.component :: Frame).LayoutOrder = page.order

    table.insert(tabs, {
      name = page.title,
      order = page.order,
    })
  end

  return New "Frame" {
    Name = "Pages",
    BackgroundTransparency = 1,
    Size = props.size or UDim2.new(1, 0, 1, 0),

    [Children] = {
      TabSelector {
        tabs = tabs,
        tabIndex = props.pageIndex,

        offset = props.offset,
      },

      New "Frame" {
        Name = "Body",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -(props.offset or 30)),
        Position = Computed(function()
          return UDim2.new(-props.pageIndex:get() + 1, 0, 0, props.offset or 30)
        end),

        [Children] = {
          New "UIListLayout" {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
          },

          ForPairs(props.pages, function(index, page)
            if props.layout then
              if type(props.layout) == "table" then
                for _, layoutObject in props.layout do
                  layoutObject:Clone().Parent = page.component
                end
              else
                props.layout:Clone().Parent = page.component
              end
            end

            return index, page.component
          end, Fusion.Cleanup)
        }
      }
    }
  }
end