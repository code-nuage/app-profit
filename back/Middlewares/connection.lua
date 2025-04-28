local jwt = require("jwt")

local secret = require("../secret")

return function(jwt_token)
    local payload = assert(jwt.verify(jwt_token, {secret = secret.secret_key}))

    if payload then
        return true
    end
    
    return false
end