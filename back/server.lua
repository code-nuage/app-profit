-- ⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀
-- ⠀⣀⠚⠀⠁⠈⠀⠹⣄⠀
-- ⠸⣀⡀⠀⠀⠀⠀⢀⡸⠃
-- ⠀⠀⠳⠴⠒⠶⠞⠁⠀⠀
--  code-nuage

local http = require("http")

local weblit = require("weblit")

local config = require("config")

require("./Utils/startup")()                                                   -- First startup

local user_route = require("./Routes/user")
local category_route = require("./Routes/category")

local app = weblit.app.bind({host = config.server.host, port = config.server.port})
.use(weblit.logger)
.use(weblit.autoHeaders)
.use(function (req, res, next)
    res.headers["Access-Control-Allow-Origin"] = "*"
    res.headers["Access-Control-Allow-Methods"] = "GET, POST, PATCH, DELETE, OPTIONS"
    res.headers["Access-Control-Allow-Headers"] = "Content-Type"

    if req.method == "OPTIONS" then                                            -- F*ck wat da hell, weblit does not support catch all paths... Got brainf*cked, never anymore
        res.code = 204
        res.body = ""

        return
    end

    next()
end)

user_route(app)
category_route(app)

app.start()