local ls = require("luasnip")
local extras = require("luasnip.extras")

local s = ls.snippet
local i = ls.insert_node
local rep = extras.rep
local l = extras.l
local fmt = require("luasnip.extras.fmt").fmt

local M = {
	-- React Function Component
	s(
		{ trig = "rfc", dscr = "React Function Component" },
		fmt(
			table.concat({
				"import React from 'react';",
				"",
				"const {} = (props) => {{",
				"  return (",
				"    <>",
				"      {}",
				"    </>",
				"  );",
				"}};",
				"",
				"export default {};",
			}, "\n"),
			{ i(1), i(2), i(2) }
		)
	),

	-- useEffect
	s(
		{ trig = "uef", dscr = "useEffect" },
		fmt(
			table.concat({
				"useEffect(() => {{",
				"  {}",
				"}}, [{}]);",
			}, "\n"),
			{ i(1), i(2) }
		)
	),

	-- useState
	s(
		{ trig = "ust", dscr = "useState" },
		fmt(
			table.concat({
				"const [{}, set{setter}] = useState({});",
			}, "\n"),
			{ i(1, "state"), i(2, "initialValue"), setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1) }
		)
	),

	-- Import
	s(
		{ trig = "imp", dscr = "Import" },
		fmt(
			table.concat({
				"import {} from '{}';",
			}, "\n"),
			{ i(1, "name"), i(2, "module") }
		)
	),

	-- Generator Function with try catches
	s(
		{ trig = "gen", dscr = "Generator Function with try catches" },
		fmt(
			table.concat({
				"function* {}({{payload}}) {{",
				"  try {{",
				"    {}",
				"  }} catch (err) {{",
				"    {}",
				"  }}",
				"}}",
			}, "\n"),
			{ i(1, "name"), i(2), i(3) }
		)
	),
}

return M
