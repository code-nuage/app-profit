local json = require("json")

local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")

local model = require("../Models/category_item")

--+ FORMAT CHECKING FUNCTIONS +--

--+     CONTROLLER     +--
local controller = {}

--+ CREATE +--
function controller.create(json_data)
    local data = json.decode(json_data)
end

return controller