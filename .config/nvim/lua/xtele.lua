local previewers = require("telescope.previewers")

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
defaults={
    prompt_prefix   =   " ➜ ",
    buffer_previewer_maker = new_maker,
    file_ignore_patterns = {
        ".jpeg",".fits",".png",".svg",".pdf",".dvi",".pickle",".jpg",".eps",".ps"
    },
    layout_stratege="horizontal",
    layout_config = {
        horizontal = {height=100, width=200},
        preview_cutoff = 10,
        preview_width  = 0.60,
	},
},
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
