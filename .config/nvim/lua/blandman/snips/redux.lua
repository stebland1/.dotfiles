local ls = require("luasnip")
local extras = require("luasnip.extras")

local s = ls.snippet
local i = ls.insert_node
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

local M = {
	-- Redux actions
	s(
		{ trig = "actions", dscr = "Create 3 actions; req, success, fail" },
		fmt(
			table.concat({
				"export const {}Action = ({}) => ({{",
				"  type: {},",
				"  payload: {{{}}},",
				"}});",
				"",
				"export const {}SuccessAction = ({}) => ({{",
				"  type: {}_SUCCESS,",
				"  payload: {{{}}},",
				"}});",
				"",
				"export const {}FailureAction = ({}) => ({{",
				"  type: {}_FAILURE,",
				"  payload: {{{}}},",
				"}});",
			}, "\n"),
			{ i(1), i(2), i(3), rep(2), rep(1), i(4), rep(3), rep(4), rep(1), i(5), rep(3), rep(5) }
		)
	),
	s(
		{ trig = "action", dscr = "Create an action" },
		fmt(
			table.concat({
				"export const {}Action = ({}) => ({{",
				"  type: {},",
				"  payload: {{{}}},",
				"}});",
			}, "\n"),
			{ i(1), i(2), i(3), rep(2) }
		)
	),
	-- Redux reducer
	s(
		{ trig = "reducer", dscr = "Create a reducer" },
		fmt(
			table.concat({
				"import produce from 'immer';",
				"",
				"export const initialState = {{",
				"  {}",
				"}};",
				"",
				"const {}Reducer = produce((draft, action) => {{",
				"  switch (action.type) {{",
				"    case {}:",
				"      break;",
				"  }}",
				"}}, initialState);",
				"",
				"export default {}Reducer;",
			}, "\n"),
			{ i(1), i(2), i(3), rep(2) }
		)
	),

	s(
		{ trig = "uis", dscr = "Use inject state hook" },
		fmt(
			table.concat({
				"import {{useSelector}} from 'react-redux';",
				"import {{createSelector}} from 'reselect';",
				"import useInjectSaga from 'ap3-foundations-ui/lib/store/use-inject-saga';",
				"import useInjectReducer from 'ap3-foundations-ui/lib/store/use-inject-reducer';",
				"",
				"import {{REDUCER_KEY, SAGA_KEY}} from './constants';",
				"import reducer from './reducer';",
				"import saga from './saga';",
				"",
				"const selectIsReducerInitialized = createSelector(",
				"  (state) => state[REDUCER_KEY],",
				"  (state) => !!state,",
				");",
				"",
				"const useInjectState = () => {{",
				"  useInjectReducer({{key: REDUCER_KEY, reducer}});",
				"  useInjectSaga({{key: SAGA_KEY, saga}});",
				"",
				"  const isReducerReady = useSelector(selectIsReducerInitialized);",
				"",
				"  return isReducerReady;",
				"}};",
				"",
				"export default useInjectState;",
			}, "\n"),
			{}
		)
	),
	-- Redux action creator constants
	s(
		{ trig = "constants", dscr = "Create 3 constants for your action creator; req, success, fail" },
		fmt(
			table.concat({
				"export const {} = '{}/{}/{}';",
				"export const {}_SUCCESS = '{}/{}/{}_SUCCESS';",
				"export const {}_FAILURE = '{}/{}/{}_FAILURE';",
			}, "\n"),
			{ i(1), i(2), i(3), rep(1), rep(1), rep(2), rep(3), rep(1), rep(1), rep(2), rep(3), rep(1) }
		)
	),
	s(
		{ trig = "constant", dscr = "Create a constant for your action creator" },
		fmt(
			table.concat({
				"export const {} = '{}/{}/{}';",
			}, "\n"),
			{ i(1), i(2), i(3), rep(1) }
		)
	),
	-- Selectors
	s(
		{ trig = "makeSelect", dscr = "Make a createSelector" },
		fmt(
			table.concat({
				"export const makeSelect{} = () => createSelector({}, ({}) => {}.{});",
			}, "\n"),
			{ i(1), i(2), i(3), rep(3), i(4) }
		)
	),
	s(
		{ trig = "select", dscr = "Create selector" },
		fmt(
			table.concat({
				"const select{} => createSelector({}, ({}) => {}.{});",
			}, "\n"),
			{ i(1), i(2), i(3), rep(3), i(4) }
		)
	),
	s(
		{ trig = "sagaErr", dscr = "Saga error handling" },
		fmt(
			table.concat({
				"const parsedError = err instanceof RequestError ? yield err.parseError() : {{}};",
				"switch (parsedError.code) {{",
				"  case statusCodes.{}:",
				"    {}",
				"    break;",
				"  default:",
				"    {}",
				"    break;",
				"}}",
			}, "\n"),
			{ i(1), i(2), i(3) }
		)
	),
}

return M
