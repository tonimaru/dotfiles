if vim.fn.has('wsl') == 1 then
    if vim.fn.executable('wl-copy') ~= 0 and vim.fn.executable('wl-paste') ~= 0 then
        vim.g.clipboard = {
            name = 'wl-clipboard (wsl)',
            copy = {
                ['+'] = 'wl-copy --foreground --type text/plain',
                ['*'] = 'wl-copy --foreground --primary --type text/plain',
            },
            paste = {
                ["+"] = (function()
                    return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { '' }, 1) -- '1' keeps empty lines
                end),
                ["*"] = (function()
                    return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', { '' }, 1)
                end),
            },
            cache_enabled = true,
        }
    elseif vim.fn.executable('win32yank.exe') then
        vim.g.clipboard = {
            name = 'win32yank (wsl)',
            copy = {
                ['+'] = 'win32yank.exe -i --crlf',
                ['*'] = 'win32yank.exe -i --crlf',
            },
            paste = {
                ['+'] = 'win32yank.exe -o --lf',
                ['*'] = 'win32yank.exe -o --lf',
            },
            cache_enabled = false,
        }
    end
end
