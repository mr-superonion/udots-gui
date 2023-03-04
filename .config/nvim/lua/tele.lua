local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local fb_actions = require "telescope".extensions.file_browser.actions

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 1500000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require('telescope').setup{
extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
    },
    file_browser = {
        hidden = true,
        mappings = {
            i = {
                ["<C-a>"] = fb_actions.toggle_hidden,
            },
        },
    },
},

defaults={
    prompt_prefix   =   " > ",
    sorting_strategy=   "ascending",
    buffer_previewer_maker = new_maker,
    file_ignore_patterns = {
        ".jpeg$",".fits$",".png$",".svg$",".pdf$",".dvi$",".pickle$",
        ".jpg$",".eps$",".ps$",".xdv", ".git/"
    },
    layout_stratege="horizontal",
    layout_config = {
        horizontal = {height=100, width=200},
        preview_cutoff =    10,
        preview_width  =    0.60,
        prompt_position=    "top",
	},
    cache_picker=   {
        num_pickers =   10,
        limit_entries=  100,
    },
    preview = {
        timeout = 500,
        msg_bg_fillchar = ">",
    },
    vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
    },
},
}

require('telescope').load_extension('fzf')
require("telescope").load_extension('file_browser')
vim.api.nvim_set_keymap(
  "n",
  "<space>ff",
  "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
  {noremap = true}
)
