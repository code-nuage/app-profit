-- ⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀
-- ⠀⣀⠚⠀⠁⠈⠀⠹⣄⠀
-- ⠸⣀⡀⠀⠀⠀⠀⢀⡸⠃
-- ⠀⠀⠳⠴⠒⠶⠞⠁⠀⠀
--  code-nuage

local http = require("http")

local weblit = require("weblit")

local config = require("config")

local user_route = require("./Routes/user")
local category_route = require("./Routes/category")

local app = weblit.app.bind({host = config.server.host, port = config.server.port})
.use(weblit.logger)
.use(weblit.autoHeaders)

user_route(app)
category_route(app)

app.start()