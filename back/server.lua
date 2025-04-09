local weblit = require('weblit')

local controller_user = require("./Controllers/user")

weblit.app
  .bind({host = "127.0.0.1", port = 1337})

  -- Configure weblit server
  .use(weblit.logger)
  .use(weblit.autoHeaders)

  .route({ method = "GET", path = "/users" }, function(req, res)
    res.body, res.code = controller_user.read_all()
    res.headers["Content-Type"] = "application/json"
  end)

  .route({ method = "POST", path = "/user" }, function(req, res)
    res.body, res.code = controller_user.create(req.body)
    res.headers["Content-Type"] = "text/plain"
  end)
  .route({ method = "GET", path = "/user/:id" }, function(req, res)
    res.body, res.code =  controller_user.read(req.params.id)
    res.headers["Content-Type"] = "application/json"
  end)

  -- Start the server
  .start()