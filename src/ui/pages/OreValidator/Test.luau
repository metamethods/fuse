local types = require(script.Parent.Parent.Parent.Parent.types)
local list = require(script.Parent.Parent.Parent.Parent.util.list)
local map = require(script.Parent.Parent.Parent.Parent.util.map)

local Test = {}

function Test.result(type: "ok" | "fail" | "warn", message: string, details: {string | Instance}?): types.TestResult
  return {
    type = type,
    message = `{message}{details and `\nDetails: <b>{details and list(map(details, function(v)
      if typeof(v) == "Instance" then return `<u>{v:GetFullName()}</u>` end
      return v
    end), 10) or ""}</b>` or ""}`,
  }
end

function Test.ok(message: string, details: {string}?): types.TestResult
  return Test.result("ok", message, details)
end

function Test.fail(message: string, details: {string}?): types.TestResult
  return Test.result("fail", message, details)
end

function Test.warn(message: string, details: {string}?): types.TestResult
  return Test.result("warn", message, details)
end

function Test.define(title: string, description: string, fn: (ore: BasePart) -> types.TestResult): types.TestDefinition
  return {
    title = title,
    description = description,
    fn = fn,
  }
end

return Test