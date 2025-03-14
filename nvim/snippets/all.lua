local extras = require("luasnip.extras")
local conds = require("luasnip.extras.expand_conditions")

return {
  s("today", { extras.partial(os.date, "%D") }, { condition = conds.line_begin })
}
