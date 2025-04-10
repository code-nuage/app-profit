local weblit = require("weblit")
local goodbwhy = require("goo-db-why")

local controller_user = require("./Controllers/user")

goodbwhy.select_db("Database")

weblit.app
  .bind({host = "127.0.0.1", port = 1337})

  -- Configure weblit server
  .use(weblit.logger)
  .use(weblit.autoHeaders)

  .route({ method = "GET", path = "/"}, function (req, res)
    res.body, res.code = "Profit DB", 200
    res.headers["Content-Type"] = "text/plain"
  end)

  .route({ method = "GET", path = "/users" }, function(req, res)
    res.body, res.code = controller_user.read_all()
    res.headers["Content-Type"] = "application/json"
  end)

  .route({ method = "POST", path = "/user" }, function(req, res)
    res.body, res.code = controller_user.create(req.body)
    res.headers["Content-Type"] = "text/plain"
  end)

  .route({ method = "GET", path = "/user/:id" }, function(req, res)
    res.body, res.code = controller_user.read(tonumber(req.params.id))
    res.headers["Content-Type"] = "application/json"
  end)

  .route({ method = "PATCH", path="/user/:id" }, function (req, res)
    res.body, res.code = controller_user.update(tonumber(req.params.id), req.body)
    res.headers["Content-Type"] = "text/plain"
  end)

  .route({ method = "DELETE", path="/user/:id" }, function (req, res)
    res.body, res.code = controller_user.delete(tonumber(req.params.id))
    res.headers["Content-Type"] = "text/plain"
  end)

  -- Start the server
  .start()