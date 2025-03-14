local function is_math()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local autosnippet = require("luasnip").extend_decorator.apply(s, { snippetType = "autosnippet" })
local automath = require("luasnip").extend_decorator.apply(s, { snippetType = "autosnippet", condition = is_math })

return {
  s("daily",
    t(
      {
        "#daily-plan",
        "",
        "- [ ] " }
    )),
  autosnippet(
    {
      trig = "(%a)(%d)",
      regTrig = true,
      name = "auto subscript single digit",
      dscr = "Auto subscript: typing x2 -> x_2",
    },
    fmta([[<>_<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = is_math }
  ),
  automath("`a", t("\\alpha")),
  automath("`b", t("\\beta")),
  automath("`g", t("\\gamma")),
  automath("`t", t("\\theta")),
  automath("`l", t("\\lambda")),
  automath("`k", t("\\kappa")),
  automath("`r", t("\\rho")),
  postfix({ trig = ".hat", match_pattern = "\\*[%w%.%_%-]+$", snippetType = "autosnippet" }, {
    f(function(_, parent)
      return "\\hat{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
    end, { condition = is_math }),
  })
}
