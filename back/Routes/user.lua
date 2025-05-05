local jwt = require("jwt")

local moreutils = require("../Utils/more-utils")

local secret_key = require("../config").secret

local controller = require("../Controllers/user")

local connection_middleware = require("../Middlewares/connection")
local role_middleware = require("../Middlewares/role")

return function(app)
    app.route({method = "POST", path = "/user"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.create(req.body)
    end)
    .route({method = "GET", path = "/me"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.me(req.headers["Cookie"])
    end)
    .route({method = "GET", path = "/user/:get"}, function(req, res)
        if string.match(req.params.get, "^%d+$") then                          -- Waits for a normal ID
            res.body,
            res.code,
            res.headers["Content-Type"] = controller.read_by_id(tonumber(req.params.get))
        end
        if string.match(req.params.get, "^[%w%.%-_]+@[%w%.%-_]+%.%a%a+$") then -- Waits for a email
            res.body,
            res.code,
            res.headers["Content-Type"] = controller.read_by_email(req.params.get)
        end
    end)
    .route({method = "GET", path = "/users"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.read_all()
    end)
    .route({method = "PATCH", path= "/user/:id"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.update_by_id(tonumber(req.params.id), req.body)
    end)
    .route({method = "DELETE", path = "/user/:id"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.delete(tonumber(req.params.id))
    end)
end