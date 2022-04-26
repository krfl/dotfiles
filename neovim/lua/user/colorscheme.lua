local status_ok, catp = pcall(require, "catppuccin")
if not status_ok then
    return
end

catp.setup {
    transparent_background = false,
    term_colors = false,
    styles = {
    	comments = "italic",
    	functions = "italic",
    	keywords = "italic",
    	strings = "NONE",
    	variables = "italic",
    },
    integrations = {
    	treesitter = true,
    	native_lsp = {
    		enabled = true,
    		virtual_text = {
    			errors = "italic",
    			hints = "italic",
    			warnings = "italic",
    			information = "italic",
    		},
    		underlines = {
    			errors = "underline",
    			hints = "underline",
    			warnings = "underline",
    			information = "underline",
    		},
    	},
    	lsp_trouble = false,
    	cmp = true,
    	lsp_saga = false,
    	gitgutter = false,
    	gitsigns = true,
    	telescope = true,
    	nvimtree = {
    		enabled = true,
    		show_root = false,
    		transparent_panel = false,
    	},
    	neotree = {
    		enabled = false,
    		show_root = false,
    		transparent_panel = false,
    	},
    	which_key = false,
    	indent_blankline = {
    		enabled = true,
    		colored_indent_levels = false,
    	},
    	dashboard = true,
    	neogit = false,
    	vim_sneak = false,
    	fern = false,
    	barbar = false,
    	bufferline = true,
    	markdown = true,
    	lightspeed = false,
    	ts_rainbow = false,
    	hop = false,
    	notify = true,
    	telekasten = true,
    	symbols_outline = true,
    }
}

vim.cmd [[
try
    set background=dark
    colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
    " make it obvious something is wrong
    set background=dark
    colorsheme blue
endtry
]]
