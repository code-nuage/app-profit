local user_controller = require("../Controllers/user")

return function(req, role)
    local jwt_token = req.headers["Cookie"]

    if jwt_token then
        local user = user_controller.read_by_email()
    end
end