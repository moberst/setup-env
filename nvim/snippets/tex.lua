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
	autosnippet({ trig = "ita", wordTrig = true }, fmta([[\textit{<>}<>]], { i(1), i(2) })),
	autosnippet({ trig = "bf", wordTrig = true }, fmta([[\textbf{<>}<>]], { i(1), i(2) })),
	autosnippet("sec", fmta([[\section{<>}<>]], { i(1), i(2) }), { condition = conds.line_begin }),
	autosnippet("sub", fmta([[\subsection{<>}<>]], { i(1), i(2) }), { condition = conds.line_begin }),
	autosnippet("ssub", fmta([[\subsubsection{<>}<>]], { i(1), i(2) }), { condition = conds.line_begin }),
	autosnippet(
		"box",
		fmta(
			[[
	    \begin{tcolorbox}
	    <>
			\tcblower
			<>
	    \end{tcolorbox}
	    <>]],
			{ i(1), i(2), i(3) }
		),
		{ condition = conds.line_begin }
	),
	autosnippet(
		"item",
		fmta(
			[[
	    \begin{itemize}
	    \item <>
	    \end{itemize}
	    <>]],
			{ i(1), i(2) }
		),
		{ condition = conds.line_begin }
	),
	autosnippet(
		"beg",
		fmta(
			[[
	    \begin{<>}
	    <>
	    \end{<>}
	    ]],
			{ i(1), i(2), rep(1) }
		),
		{ condition = conds.line_begin }
	),
	autosnippet(
		"ali",
		fmta(
			[[
	    \begin{align*}
	    <>
	    \end{align*}
	    ]],
			{ i(1) }
		),
		{ condition = conds.line_begin }
	),
	autosnippet(
		"eq",
		fmta(
			[[
	      \begin{equation}
	      <>
	      \end{equation}
	    ]],
			i(1)
		),
		{ condition = conds.line_begin }
	),
	s("frac", fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = is_math }),
	s("sum", fmta("\\sum_{<>}^{<>}", { i(1, "i=1"), i(2, "n") }), { condition = is_math }),
	s(
		"sfig",
		fmta(
			[[
	\begin{figure}[t]
	\centering
		\begin{subfigure}[<>]{<>}
		\centering
			\includegraphics[width=<>]{figs/<>}
		\caption{<>}%
		\label{fig:<>}
		\end{subfigure}
	\caption{<>}%
	\label{fig:<>}
	\end{figure}
	<>
	  ]],
			{ i(1, "h"), i(2, "\\textwidth"), i(3, "0.9\\linewidth"), i(4), i(5), i(6), i(7), i(8), i(9) }
		),
		{ condition = conds.line_begin }
	),
	s(
		"res",
		fmta(
			[[
	\begin{restatable}[<>]{<>}{<>}\label{<>:<>}
		<>
	\end{restatable}
	<>
	]],
			{ i(1, "name"), i(2, "theorem"), i(3, "ShortName"), rep(2), i(4, "label"), i(5), i(6) }
		),
		{ condition = conds.line_begin }
	),
	s(
		"fig",
		fmta(
			[[
		\begin{figure}[t]
		\begin{center}
			\includegraphics[width=<>]{figs/<>}
		\end{center}
		\caption{<>}%
		\label{fig:<>}
		\end{figure}
			<>
	  ]],
			{ i(1, "0.5\\linewidth"), i(2), i(3), i(4), i(5) }
		),
		{ condition = conds.line_begin }
	),
	s(
		"tikz",
		fmta(
			[[
		\begin{figure}[t]
		\begin{center}
		\begin{tikzpicture}[
			obs/.style={circle, draw=gray!90, fill=gray!30, very thick, minimum size=5mm},
			uobs/.style={circle, draw=gray!90, fill=gray!10, dotted, minimum size=5mm},
			bend angle=30]
			\node[uobs] (U) {$U$} ;
			\node[obs] (Y) [below right=of U]  {$Y$};
			\node[obs] (X) [below left=of U] {$X$} ;
			\draw[-latex, thick] (X) -- (Y) node[midway, below] {$\alpha$};
			\draw[-latex, thick] (U) -- (X);
			\draw[-latex, thick] (U) -- (Y);
			<>
		\end{tikzpicture}
		\end{center}
		\caption{<>}%
		\label{fig:<>}
		\end{figure}
		<>
	  ]],
			{ i(1), i(2), i(3), i(4) }
		),
		{ condition = conds.line_begin }
	),
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
	-- postfix({ trig = "^", match_pattern = "\\*[%w%.%_%-]+$", snippetType = "autosnippet" }, {
	-- 	f(function(_, parent)
	-- 		return "{" .. parent.snippet.env.POSTFIX_MATCH .. "}^{"
	-- 	end, { condition = is_math }),
	-- }),
	postfix({ trig = ".tilde", match_pattern = "\\*[%w%.%_%-]+$", snippetType = "autosnippet" }, {
		f(function(_, parent)
			return "\\tilde{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
		end, { condition = is_math }),
	}),
}
