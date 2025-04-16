local controller = require("../Controllers/category")

return function(app)
    app.route({method = "POST", path = "/category"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.create(req.body)
    end)
    .route({method = "GET", path = "/category/:id"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.read_by_id(tonumber(req.params.id))
    end)
    .route({method = "GET", path = "/categories"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.read_all()
    end)
    .route({method = "DELETE", path = "/category/:id"}, function(req, res)
        res.body, res.code, res.headers["Content-Type"] = controller.delete(tonumber(req.params.id))
    end)
end