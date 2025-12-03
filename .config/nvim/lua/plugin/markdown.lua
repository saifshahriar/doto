return {
	-- Render markdown table
	-- {
	-- 	"Kicamon/markdown-table-mode.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("markdown-table-mode").setup({
	-- 			filetype = {
	-- 				"*.md",
	-- 				"*.rmd",
	-- 			},
	-- 			options = {
	-- 				insert = true, -- when typeing "|"
	-- 				insert_leave = true, -- when leaving insert
	-- 			},
	-- 		})
	-- 	end,
	-- },
	--
	-- Render markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({
				heading = {
					enabled = true, -- Turn on / off heading icon & background rendering
					render_modes = true, -- Additional modes to render headings
					sign = true, -- Turn on / off any sign column related rendering
					position = "left", -- Determines how icons fill the available space:
					--  right:   '#'s are concealed and icon is appended to right side
					--  inline:  '#'s are concealed and icon is inlined on left side
					--  overlay: icon is left padded with spaces and inserted on left hiding any additional '#'
					-- Replaces '#+' of 'atx_h._marker'
					-- The number of '#' in the heading determines the 'level'
					-- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
					icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
					signs = { "󰫎 " },
					-- Width of the heading background:
					--  block: width of the heading text
					--  full:  full width of the window
					-- Can also be a list of the above values in which case the 'level' is used
					-- to index into the list using a clamp
					width = "full",
					-- Amount of margin to add to the left of headings
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Margin available space is computed after accounting for padding
					-- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
					left_margin = 0,
					-- Amount of padding to add to the left of headings
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
					left_pad = 0,
					-- Amount of padding to add to the right of headings when width is 'block'
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
					right_pad = 0,
					-- Minimum width to use for headings when width is 'block'
					-- Can also be a list of integers in which case the 'level' is used to index into the list using a clamp
					min_width = 0,
					-- Determines if a border is added above and below headings
					-- Can also be a list of booleans in which case the 'level' is used to index into the list using a clamp
					border = false,
					-- Always use virtual lines for heading borders instead of attempting to use empty lines
					border_virtual = false,
					-- Highlight the start of the border using the foreground highlight
					border_prefix = false,
					above = "▄",
					below = "▀",
					-- The 'level' is used to index into the list using a clamp
					-- Highlight for the heading icon and extends through the entire line
					backgrounds = {
						"RenderMarkdownH1Bg",
						"RenderMarkdownH2Bg",
						"RenderMarkdownH3Bg",
						"RenderMarkdownH4Bg",
						"RenderMarkdownH5Bg",
						"RenderMarkdownH6Bg",
					},
					-- The 'level' is used to index into the list using a clamp
					-- Highlight for the heading and sign icons
					foregrounds = {
						"RenderMarkdownH1",
						"RenderMarkdownH2",
						"RenderMarkdownH3",
						"RenderMarkdownH4",
						"RenderMarkdownH5",
						"RenderMarkdownH6",
					},
				},
			})
		end,
	},
}
