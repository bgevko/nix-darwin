return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.opt.termguicolors = true

			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "none",
					right_mouse_command = "bdelete! %d",

					indicator = {
						style = "icon",
						icon = "▎",
					},

					buffer_close_icon = "x",
					modified_icon = "●",
					close_icon = "x",
					left_trunc_marker = "",
					right_trunc_marker = "",

					max_name_length = 18,
					max_prefix_length = 15,
					truncate_names = true,

					tab_size = 18,

					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,

					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							text_align = "center",
						},
					},

					color_icons = true,
					get_element_icon = function(element)
						-- element.path, element.extension, element.directory
						return require("nvim-web-devicons").get_icon(element.filename)
					end,

					show_buffer_icons = true,
					show_buffer_close_icons = false,
					show_close_icon = false,
					show_tab_indicators = true,

					persist_buffer_sort = true,
					separator_style = "thin", -- "slant" | "thick" | "thin"
					enforce_regular_tabs = false,
					always_show_bufferline = true,
				},
			})
		end,
	},
}
