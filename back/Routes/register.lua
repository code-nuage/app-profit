local middleware = require("../Middlewares/register")

return function(app)
    app.route({method = "POST", path = "/register"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = middleware(req.body)
    end)
end