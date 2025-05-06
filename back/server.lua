-- ⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀
-- ⠀⣀⠚⠀⠁⠈⠀⠹⣄⠀
-- ⠸⣀⡀⠀⠀⠀⠀⢀⡸⠃
-- ⠀⠀⠳⠴⠒⠶⠞⠁⠀⠀
--  code-nuage

local http = require("http")

local weblit = require("weblit")

local config = require("./config")

require("./Utils/startup")()                                                   -- First startup

local register_route = require("./Routes/register")
local login_route = require("./Routes/login")

local user_route = require("./Routes/user")
local category_route = require("./Routes/category")

local app = weblit.app.bind({host = config.server.host, port = config.server.port})
.use(weblit.logger)
.use(weblit.autoHeaders)
.use(function (req, res, next)
    local origin = req.headers["Origin"]                                       -- Set the allowed origin to the connection origin to avoid weird things with CORS and "*" allowed
    res.headers["Access-Control-Allow-Origin"] = origin
    res.headers["Access-Control-Allow-Methods"] = "GET, POST, PATCH, DELETE, OPTIONS"
    res.headers["Access-Control-Allow-Headers"] = "Content-Type"
    res.headers["Access-Control-Allow-Credentials"] = true

    if req.method == "OPTIONS" then                                            -- F*ck wat da hell, weblit does not support catch all paths... Got brainf*cked, never anymore
        res.code = 204
        res.body = ""
        return
    end

    next()
end)

register_route(app)
login_route(app)

user_route(app)
category_route(app)

app.start()