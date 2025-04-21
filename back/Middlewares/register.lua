local json = require("json")
local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")

local model = require("../Models/user")
local controller = require("../Controllers/user")

return function(json_data)
    local data = json.decode(json_data)

    if data then
        if model.user_exists(data.email) then
            return json.encode({error = "User already exists"}),
            http_code.BAD_REQUEST,
            mime.json
        end

        local returned_data, returned_code, returned_mime = controller.create(json_data);

        return returned_data,
        returned_code,
        returned_mime
    end

    return json.encode({error = "Can't decode data"}),
    http_code.BAD_REQUEST,
    mime.json
end