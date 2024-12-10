vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    -- vim.opt_local.wrap = false
    -- need to turn this off for image.nvim to work properly
    vim.opt_local.spell = true
  end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})

-- Helper function to remove trailing slashes
local function strip_trailing_slash(path)
    if path:sub(-1) == "/" then
        return path:sub(1, -2)
    else
        return path
    end
end

-- Define absolute base directories
-- Ensure these paths do NOT end with a trailing slash
local base_source = "/home/neil/neil/notes/source"      -- Replace with your actual absolute path
local base_compiled = "/home/neil/neil/notes/compiled"  -- Replace with your actual absolute path

-- Function to convert Markdown to PDF with detailed logging
local function convert_to_pdf()
    -- Get the full path of the current file
    local full_path = vim.fn.expand("%:p") -- e.g., /home/neil/neil/notes/source/subdir/file_name.md

    -- Normalize base_source and base_compiled by stripping trailing slashes
    local source_abs = strip_trailing_slash(vim.fn.fnamemodify(base_source, ":p"))      -- Absolute path to notes/source
    local compiled_abs = strip_trailing_slash(vim.fn.fnamemodify(base_compiled, ":p"))  -- Absolute path to notes/compiled

    -- Validate that base_source exists
    if not vim.fn.isdirectory(source_abs) then
        vim.notify("Source directory does not exist: " .. source_abs, vim.log.levels.ERROR)
        return
    end

    -- Validate or create base_compiled directory
    if not vim.fn.isdirectory(compiled_abs) then
        vim.notify("Compiled directory does not exist. Attempting to create: " .. compiled_abs, vim.log.levels.INFO)
        local mkdir_result = vim.fn.mkdir(compiled_abs, "p")
        if mkdir_result == 0 then
            vim.notify("Failed to create compiled directory: " .. compiled_abs, vim.log.levels.ERROR)
            return
        else
            vim.notify("Successfully created compiled directory: " .. compiled_abs, vim.log.levels.INFO)
        end
    end

    -- Ensure the current file is inside the source directory
    -- Append a single slash to source_abs for correct comparison
    local source_with_slash = source_abs .. "/"
    if not vim.startswith(full_path, source_with_slash) then
        vim.notify("File is not inside source directory: " .. source_abs, vim.log.levels.ERROR)
        return
    end

    -- Get the relative path from source directory
    local relative_path = full_path:sub(#source_abs + 2) -- +2 to remove the '/' separator

    -- Change the extension from .md to .pdf
    local relative_pdf_path = vim.fn.fnamemodify(relative_path, ":r") .. ".pdf"

    -- Define the full output path in the compiled directory
    local output_pdf = compiled_abs .. "/" .. relative_pdf_path

    -- Get the directory part of the output path
    local output_dir = vim.fn.fnamemodify(output_pdf, ":h")

    -- Create the output directory recursively if it doesn't exist
    local mkdir_result = vim.fn.mkdir(output_dir, "p")
    if mkdir_result == 0 and not vim.fn.isdirectory(output_dir) then
        vim.notify("Failed to create directory: " .. output_dir, vim.log.levels.ERROR)
        return
    end

    -- Prepare the Pandoc command
    local cmd = string.format(
        'pandoc -s "%s" -o "%s" >/dev/null 2>&1',
        full_path,
        output_pdf
    )

    -- Execute the command
    vim.fn.system(cmd)

    -- Check for errors
    if vim.v.shell_error ~= 0 then
        vim.notify("Pandoc conversion failed for: " .. full_path, vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "/home/neil/neil/notes/source/**/*.md",
    callback = function()
        convert_to_pdf()
    end,
})
