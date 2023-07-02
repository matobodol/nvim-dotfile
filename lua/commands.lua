-- [[ COMMANDS ]]

--vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

 -- disable nomor baris pada TermOpen
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = group,
  callback = function()
    vim.cmd('setlocal nonumber')
		vim.api.nvim_feedkeys('i', 'n', false)
  end,
})

-- COMPILE AND RUN
function compile_and_run()
	local file_extension = vim.fn.expand('%:e')
	local filename = vim.fn.expand('%')
	local output_name = vim.fn.expand('%:r')
	
	vim.api.nvim_command(':w')

	local compile_command = ''
	if file_extension == 'rs' then
		compile_command = 'rustc '..filename..' -o '..output_name
	elseif file_extension == 'cpp' then
		compile_command = 'g++ '..filename..' -o '..output_name
	end

	if compile_command ~= '' then
		vim.fn.system(compile_command)
		local run_command = 'split term://bash -c ' ..output_name
		vim.api.nvim_command(run_command)
		
		-- Hapus file binari setelah dieksekusi
    	vim.schedule(function()
    	  os.remove(output_name)
    	end)
	end

end

vim.api.nvim_command('command! -nargs=0 Cm lua compile_and_run()')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash_ls',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})
