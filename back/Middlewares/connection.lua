local jwt = require("jwt")

local moreutils = require("../Utils/more-utils")
local secret = require("../secret")

return function(req)
    local jwt_token = req.headers["Cookie"]
    local payload = jwt.verify(jwt_token, {secret = secret.secret_key})

    if payload then
        return true
    end

    return false
end