local json = require("json")

local login_controller = require("../Controllers/login")
local logout_controller = require("../Controllers/logout")
local connection_middleware = require("../Middlewares/connection")

local mime = require("../Utils/mime")
local http_code = require("../Utils/http-code")

return function(app)
    app.route({method = "POST", path = "/login"}, function(req, res)
        if not connection_middleware(req) then
            local body, code, set_cookie, content_type = login_controller(req.body)

            res.body = body
            res.code = code

            if set_cookie then
                res.headers["Set-Cookie"] = set_cookie
            end

            if content_type then
                res.headers["Content-Type"] = content_type
            end
        else
            res.body, res.code, res.headers["Content-Type"] = json.encode({error = "You are already connected"}),
            http_code.BAD_REQUEST,
            mime.json
        end
    end)
    .route({method = "POST", path = "/logout"}, function(req, res)
        if connection_middleware(req) then
            local body, code, set_cookie, content_type = logout_controller(req.body)

            res.body = body
            res.code = code

            if set_cookie then
                res.headers["Set-Cookie"] = set_cookie
            end

            if content_type then
                res.headers["Content-Type"] = content_type
            end
        else
            res.body, res.code, res.headers["Content-Type"] = json.encode({error = "You are not connected"}),
            http_code.BAD_REQUEST,
            mime.json
        end
    end)
end