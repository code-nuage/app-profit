local middleware = require("../Middlewares/login")

return function(app)
    app.route({method = "POST", path = "/login"}, function(req, res)
        local body, code, set_cookie, content_type = middleware(req.body)

        res.body = body
        res.code = code

        if set_cookie then
            res.headers["Set-Cookie"] = set_cookie
        end

        if content_type then
            res.headers["Content-Type"] = content_type
        end
    end)
end