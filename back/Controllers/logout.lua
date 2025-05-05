local json = require("json")

local http_code = require("../Utils/http-code")
local mime = require("../Utils/mime")
local cookiebuilder = require("../Utils/cookie-builder")

return function(req)
    local cookie = cookiebuilder("jwt", "",
    {["Path"] = "/",
    "HttpOnly",
    "Secure",
    ["SameSite"] = "None",
    "Partitioned",
    ["Max-Age"] = 1000 * 60 * 60 * 24})

    return json.encode({message = "You're logged out!"}),
    http_code.SUCCESS,
    cookie,                                                        -- Set the clear cookie
    mime.json
end