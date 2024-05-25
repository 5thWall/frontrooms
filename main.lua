fennel = require("fennel")

table.insert(package.loaders, fennel.make_searcher({ correlate = true }))

debug.traceback = fennel.traceback

local loader_builder = function(env)
  return function(filename)
    local path = filename:gsub("%.", "/") .. ".fnl"
    if love.filesystem.getInfo(filename) then
      return function(...)
        return fennel.eval(love.filesystem.read(filename), { env = env, filename = filename }, ...), filename
      end
    end
  end
end

table.insert(package.loaders, loader_builder(_G))
-- table.insert(fennel["macro-searchers"], make_love_searcher("_COMPILER"))

-- jump into Fennel
require("main.fnl")


