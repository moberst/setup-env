local function is_math()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
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
	s("idea0", {
		t("# Idea: "),
		i(1, "Description"),
		t({ "", "#research/0-ideas-inbox" }),
		t({ "", ">Note: See [[2025-03-24-091645-research-process|research process]] for instructions", "" }),
	}, { condition = conds.line_begin }),
	s("idea1", {
		t("# Idea: "),
		i(1, "Description"),
		t({ "", "#research/1-ideas" }),
		t({ "", ">Note: See [[2025-03-24-091645-research-process|research process]] for instructions", "" }),
	}, { condition = conds.line_begin }),
	s(
		"pland",
		t({
			"#daily-plan",
			"",
			"- [ ] ",
		}),
		{ condition = conds.line_begin }
	),
	s(
		"planw",
		t({
			"#weekly-plan",
			"",
			"- [ ] ",
		}),
		{ condition = conds.line_begin }
	),
	autosnippet(
		"eq",
		fmta(
			[[
      $$
      <>
      $$
    ]],
			i(1)
		),
		{ condition = conds.line_begin }
	),
	s("frac", fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = is_math }),
	s("sum", fmta("\\sum_{<>}^{<>}", { i(1, "i=1"), i(2, "n") }), { condition = is_math }),
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
	automath("`cid", t("\\stackrel{d}{\\rightarrow}")),
	automath("`cip", t("\\stackrel{p}{\\rightarrow}")),
	automath("`8", t("\\infty")),
	automath("`a", t("\\alpha")),
	automath("`b", t("\\beta")),
	automath("`g", t("\\gamma")),
	automath("`q", t("\\theta")),
	automath("`m", t("\\mu")),
	automath("`t", t("\\tau")),
	automath("`l", t("\\lambda")),
	automath("`k", t("\\kappa")),
	automath("`r", t("\\rho")),
	automath("`e", t("\\epsilon")),
	automath("`<", t("\\langle")),
	automath("`>", t("\\rangle")),
	automath("`h", t("\\eta")),
	automath("`s", t("\\sigma")),
	automath("`jl", t("\\rightarrow")),
	postfix({ trig = ".bar", match_pattern = "\\*[%w%.%_%-]+$", snippetType = "autosnippet" }, {
		f(function(_, parent)
			return "\\bar{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
		end, { condition = is_math }),
	}),
	postfix({ trig = ".hat", match_pattern = "\\*[%w%.%_%-]+$", snippetType = "autosnippet" }, {
		f(function(_, parent)
			return "\\hat{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
		end, { condition = is_math }),
	}),
	postfix({ trig = ".tilde", match_pattern = "\\*[%w%.%_%-]+$", snippetType = "autosnippet" }, {
		f(function(_, parent)
			return "\\tilde{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
		end, { condition = is_math }),
	}),
}
