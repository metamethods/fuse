local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components
local Classes = Fuse.Classes

local Fusion = require(Packages.fusion)
local Types = require(Fuse.Types)
local DescribableObject = require(Classes.DescribableObject)
local Theme = require(App.Theme)
local Padding = require(Components.Padding)
local Rounded = require(Components.Rounded)
local ListLayout = require(Components.ListLayout)
local Border = require(Components.Border)
local HeaderText = require(Components.HeaderText)
local Text = require(Components.Text)
local Button = require(Components.Button)

local New = Fusion.New
local ForPairs = Fusion.ForPairs
local Value = Fusion.Value
local Computed = Fusion.Computed
local Children = Fusion.Children

export type TestResult = {
  success: boolean,
  message: string
}

export type TestActionsProps = {
  ore: Fusion.Value<BasePart?>,
  result: Fusion.Value<TestResult?>,
  runTestFunction: () -> boolean
}

function TestActions(props: TestActionsProps): Instance
  return New "Frame" {
    Name = "Actions",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Horizontal, UDim.new(0, 8)),
      Button {
        text = "Run Test",
        disabled = Computed(function() return not props.ore:get() end),
        onClicked = props.runTestFunction,
      },
      Button {
        text = "Reset",
        disabled = Computed(function() return not props.result:get() end),
        onClicked = function() props.result:set() end,
      }
    }
  }
end

export type TestProps = {
  ore: Fusion.Value<BasePart?>,
  testObject: DescribableObject.DescribableObject<Types.TestFunction>,
}

function Test(props: TestProps): (() -> boolean, Instance)
  local result: Fusion.Value<TestResult?> = Value()

  local testPassed = Computed(function()
    local result = result:get()
    return if result then result.success else nil
  end)

  local backgroundColor = Computed(function()
    local testPassed = testPassed:get()
    if testPassed == nil then return Theme("Background"):get() end
    return testPassed 
      and Theme("Success"):get() 
      or Theme("Error"):get()
  end)

  local testMessage = Computed(function()
    local result = result:get()
    return result
      and result.message
      or "<i>This test hasn't been ran yet</i>"
  end)

  local function runTest(): boolean
    local ore = props.ore:get()
    if not ore then return false end
    local success, message = props.testObject.object(ore)
    result:set({
      success = success,
      message = message,
    })
    return success
  end

  return runTest, New "Frame" {
    Name = "Test",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),

      New "Frame" {
        Name = "TestBody",
        BackgroundColor3 = Theme "Background",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    
        [Children] = {
          Rounded(),
          Border(1),
          New "Frame" {
            Name = "Background",
            BackgroundColor3 = backgroundColor,
            BackgroundTransparency = .9,
            Size = UDim2.new(1, 0, 1, 0),

            [Children] = {
              Rounded(),
              Border(1),
            }
          },
          New "Frame" {
            Name = "TestInformation",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,

            [Children] = {
              Padding(UDim.new(0, 8)),
              ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 4)),
              HeaderText "" { Text = props.testObject.name },
              Text "" { Text = props.testObject.description },
              Text "" { Text = testMessage },
            }
          }
        }
      },
      TestActions {
        ore = props.ore,
        result = result,
        runTestFunction = runTest
      }
    }
  }
end

export type TestsProps = {
  ore: Fusion.Value<BasePart?>
}

return function(props: TestsProps): (() -> boolean, Instance)
  local testFunctions: {() -> boolean} = {}

  local function runTests()
    local allPassed = true
    for _, test in testFunctions do 
      if not test() then
        allPassed = false
      end
    end
    return allPassed
  end

  return runTests, New "Frame" {
    Name = "Tests",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),

      ForPairs(script:GetChildren(), function(i, testModule: ModuleScript)
        local testFunction, component = Test {
          ore = props.ore,
          testObject = require(testModule),
        }
  
        table.insert(testFunctions, testFunction)
  
        return i, component
      end, Fusion.cleanup)
    }
  }
end