local jwt = require("jwt")

local moreutils = require("../Utils/more-utils")
local secret_key = require("../config").secret

return function(req)
    local jwt_token = req.headers["Cookie"]

    if jwt_token then
        jwt_token, _ = jwt_token:gsub("jwt=", "")

        if jwt_token ~= "" then
            local payload = assert(jwt.verify(jwt_token, {secret = secret_key}))

            if payload then
                print("JWT valide")
                return true
            end
        end
    end

    return false
end