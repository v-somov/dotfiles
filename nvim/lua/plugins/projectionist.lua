local utils = require("config.utils")

-- Alternate files for :A/:AS/:AV/:AT (vim-rails used to provide the Rails ones).
-- A list means: open the first one that exists, else create the first.
local js = {}
for _, ext in ipairs({ "ts", "tsx", "js", "jsx" }) do
	js["*." .. ext] = { alternate = { "{}.test." .. ext, "{}.spec." .. ext } }
	js["*.test." .. ext] = { alternate = "{}." .. ext }
	js["*.spec." .. ext] = { alternate = "{}." .. ext }
end

vim.g.projectionist_heuristics = {
	-- Rails apps and engines: rspec-rails mirrors app/ and lib/ under spec/
	["Gemfile&app/"] = {
		["app/*.rb"] = { alternate = "spec/{}_spec.rb" },
		["lib/*.rb"] = { alternate = "spec/lib/{}_spec.rb" },
		["spec/lib/*_spec.rb"] = { alternate = "lib/{}.rb" },
		["spec/*_spec.rb"] = { alternate = "app/{}.rb" },
	},
	-- Plain Ruby and gems (bundle gem layout): lib/ maps to spec/ or test/ directly
	["Gemfile&!app/"] = {
		["lib/*.rb"] = { alternate = { "spec/{}_spec.rb", "test/{}_test.rb" } },
		["spec/*_spec.rb"] = { alternate = "lib/{}.rb" },
		["test/*_test.rb"] = { alternate = "lib/{}.rb" },
	},
	["go.mod"] = {
		["*.go"] = { alternate = "{}_test.go" },
		["*_test.go"] = { alternate = "{}.go" },
	},
	["pyproject.toml|setup.py|requirements.txt"] = {
		["*.py"] = { alternate = { "{}_test.py", "{dirname}/test_{basename}.py" } },
		["*_test.py"] = { alternate = "{}.py" },
		["**/test_*.py"] = { alternate = "{dirname}/{basename}.py" },
	},
	["package.json"] = js,
}

-- Skeleton for new spec files (for example created by :A), in the style of the existing specs
local spec_types = { models = "model", controllers = "controller", requests = "request", jobs = "job", mailers = "mailer" }

local function camelize(segment)
	local s = segment:gsub("_(%w)", string.upper)
	return (s:gsub("^%l", string.upper))
end

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*_spec.rb",
	callback = function(ev)
		local path = vim.api.nvim_buf_get_name(ev.buf)
		local root = vim.fs.root(path, "Gemfile")
		local rel = root and vim.fs.relpath(root, path)
		if not rel or not rel:match("^spec/") then
			return
		end
		local parts = vim.split((rel:gsub("^spec/", ""):gsub("_spec%.rb$", "")), "/")
		-- Rails mirrors app/ dirs under spec/ (spec/models/user_spec.rb -> User), plain gems do not
		local rails = vim.uv.fs_stat(root .. "/app") ~= nil
		local kind = #parts > 1 and parts[1] or nil
		if rails and kind then
			table.remove(parts, 1)
		end
		local name = table.concat(vim.tbl_map(camelize, parts), "::")
		local type = rails and spec_types[kind]
		local subject = type == "request" and ("'" .. name .. "'") or name
		local helper = vim.uv.fs_stat(root .. "/spec/rails_helper.rb") and "rails_helper" or "spec_helper"
		vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, {
			"# frozen_string_literal: true",
			"",
			"require '" .. helper .. "'",
			"",
			"RSpec.describe " .. subject .. (type and (", type: :" .. type) or "") .. " do",
			"end",
		})
	end,
})

local function runInTerminal(cmd)
	vim.cmd("split | term " .. cmd)

	-- vim.cmd("startinsert")
end

-- Test command for the current buffer (vim-rails used to provide this for Ruby).
-- Ruby: the current spec, or the :A alternate spec when in a source file. Run from the nearest Gemfile root.
-- Other languages: makeprg. Returns the command and whether it targets the current buffer.
local function test_command()
	local path = vim.api.nvim_buf_get_name(0)
	local spec = path:match("_spec%.rb$") and path or nil
	if not spec and path:match("%.rb$") then
		for _, alt in ipairs(vim.fn["projectionist#query_file"]("alternate")) do
			if alt:match("_spec%.rb$") then
				spec = alt
				break
			end
		end
		if not spec or vim.fn.filereadable(spec) == 0 then
			vim.notify("No spec file for " .. vim.fn.fnamemodify(path, ":."), vim.log.levels.WARN)
			return nil
		end
	end
	if spec then
		local root = vim.fs.root(spec, "Gemfile")
		if root then
			local cmd = "cd " .. vim.fn.shellescape(root) .. " && bundle exec rspec " .. vim.fs.relpath(root, spec)
			return cmd, spec == path
		end
	end
	return vim.bo.makeprg, true
end

global.run_current_test_file = function()
	local cmd = test_command()
	if cmd then
		runInTerminal(cmd)
	end
end
utils.lua_command("RunCurrentTestFile", "global.run_current_test_file()")

global.run_all_test_files = function()
	local cmd = test_command()
	if cmd then
		runInTerminal(cmd .. " --only-failures --fail-fast")
	end
end
utils.lua_command("RunAllTestFiles", "global.run_all_test_files()")

-- In a source file, runs the whole alternate spec (the cursor line is not a spec line)
global.run_current_test_case = function()
	local cmd, current = test_command()
	if not cmd then
		return
	end
	if current then
		cmd = cmd .. ":" .. vim.api.nvim_win_get_cursor(0)[1]
	end
	runInTerminal(cmd)
end
utils.lua_command("RunCurrentTestCase", "global.run_current_test_case()")

utils.nmap("<leader>a", ":A<cr>", { desc = "Alternate file" })
utils.nmap(",m", ":RunCurrentTestFile<cr>")
utils.nmap(",a", ":RunAllTestFiles<cr>")
utils.nmap(",.", ":RunCurrentTestCase<cr>")
