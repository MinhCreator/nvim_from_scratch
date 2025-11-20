local notify = require("notify")

return {
	notify.setup({
		fps = 60,
		render = "default", --"simple",
		stages =  "fade", --"slide",
		timeout = 1000,
		top_down = true,
		opacity = 0.15,
	}),
}
