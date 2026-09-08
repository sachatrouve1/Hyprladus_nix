return {
	-- 1. Plugin Transparent principal + styles généraux
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			local function apply_custom_highlights()
				local transparent_groups = {
					-- Dashboard d'accueil (Snacks & Alpha)
					"SnacksDashboardNormal",
					"SnacksDashboardHeader",
					"SnacksDashboardFooter",
					"SnacksDashboardDesc",
					"SnacksDashboardIcon",
					"SnacksDashboardKey",
					"SnacksDashboardDir",
					"SnacksDashboardFile",
					"SnacksDashboardSpecial",
					"AlphaHeader",
					"AlphaButtons",
					"AlphaFooter",
					"AlphaShortcut",

					-- Barre du haut (Bufferline / Tabs)
					"TabLine",
					"TabLineFill",
					"TabLineSel",
					"BufferLineFill",
					"BufferLineBackground",
					"BufferLineSeparator",

					-- Barre du bas (Neovim natif)
					"StatusLine",
					"StatusLineNC",

					-- Explorateur (Snacks Picker)
					"Directory",
					"SnacksPickerDir",
					"SnacksPickerDirectory",
					"SnacksPickerFile",
					"SnacksPickerRow",
					"SnacksPickerCol",
					"SnacksPickerNormal",
					"SnacksPickerBorder",
					"SnacksPickerBoxTitle",
					"SnacksPickerTitle",
					"SnacksPickerInput",
					"SnacksPickerInputBorder",
					"SnacksPickerInputTitle",
					"SnacksPickerTree",
					"SnacksPickerList",
					"SnacksNormal",
					"SnacksBackdrop",

					-- Cmdline & Flottants
					"NoiceCmdline",
					"NoiceCmdlinePopup",
					"NoiceCmdlinePopupBorder",
					"NoiceCmdlinePopupTitle",
					"NoiceCmdlinePrompt",
					"NormalFloat",
					"FloatBorder",
					"FloatTitle",
				}

				for _, group in ipairs(transparent_groups) do
					vim.api.nvim_set_hl(0, group, { bg = "NONE" })
				end

				-- Texte adouci pour l'explorateur
				local muted_text = "#a9b1d6"
				local tree_guides = "#565f89"
				vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = muted_text, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = muted_text, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = muted_text, bg = "NONE" })
				vim.api.nvim_set_hl(0, "Directory", { fg = muted_text, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = tree_guides, bg = "NONE" })

				-- Titres et bordures
				vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#e0af68", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerBoxTitle", { fg = "#e0af68", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#7aa2f7", bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = "#7dcfff", bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#bb9af7", bold = true, bg = "NONE" })

				-- Cmdline
				vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "#e0af68", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#7aa2f7", bg = "NONE" })
				vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = "#7dcfff", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#bb9af7", bg = "NONE" })

				-- Statuts Git
				vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#bb9af7", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = "#e0af68", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded", { fg = "#9ece6a", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted", { fg = "#f7768e", bold = true, bg = "NONE" })
				vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = "#565f89", bg = "NONE" })
			end

			apply_custom_highlights()

			vim.api.nvim_create_autocmd({ "ColorScheme", "FileType", "BufEnter" }, {
				callback = apply_custom_highlights,
			})
		end,
	},

	-- 2. Rendre Lualine (barre du bas) transparente
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			-- Récupère le thème courant ou utilise "auto"
			local theme_name = opts.options and opts.options.theme or "auto"
			local ok, theme =
				pcall(require, "lualine.themes." .. (type(theme_name) == "string" and theme_name or "auto"))

			if not ok then
				theme = require("lualine.themes.auto")
			end

			-- Met à NONE l'arrière-plan de la zone centrale (c) pour tous les modes
			local modes = { "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }
			for _, mode in ipairs(modes) do
				if theme[mode] and theme[mode].c then
					theme[mode].c.bg = "NONE"
				end
			end

			opts.options = opts.options or {}
			opts.options.theme = theme
		end,
	},

	-- 3. Transparence Bufferline (bande du haut)
	{
		"akinsho/bufferline.nvim",
		opts = {
			highlights = {
				fill = { bg = "NONE" },
				background = { bg = "NONE" },
				tab = { bg = "NONE" },
				tab_selected = { bg = "NONE" },
				tab_close = { bg = "NONE" },
				close_button = { bg = "NONE" },
				separator = { bg = "NONE" },
				separator_selected = { bg = "NONE" },
				separator_visible = { bg = "NONE" },
			},
		},
	},
}
