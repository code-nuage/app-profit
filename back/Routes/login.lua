local middleware = require("../Middlewares/login")

return function(app)
    app.route({method = "POST", path = "/login"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = middleware(req.body)
    end)
end