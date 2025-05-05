local controller = require("../Controllers/register")

return function(app)
    app.route({method = "POST", path = "/register"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller(req.body)
    end)
end