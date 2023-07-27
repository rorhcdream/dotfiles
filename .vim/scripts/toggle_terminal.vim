let s:term_buf = 0
let s:term_height = 20

function! GetFirstWindowNumberForBuffer(buffer_number)
    for win_info in getwininfo()
        if win_info['bufnr'] == a:buffer_number
            return win_info['winid']
        endif
    endfor
    return -1  " Return -1 if buffer is not open in any window
endfunction

function! TermToggle()
    if win_gotoid(GetFirstWindowNumberForBuffer(s:term_buf))
        hide
    else
        botright new
        exec "resize " . s:term_height
        try
            exec "buffer " . s:term_buf
        catch
            terminal
            let s:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let s:term_win = win_getid()
    endif
endfunction

function! ResizeWindowForBuffer(buffer_number, window_size)
    " Only resize the window if the current buffer matches the buffer
    if bufnr('%') == a:buffer_number
        execute 'resize ' . a:window_size
    endif
endfunction

augroup ResizeTermWindowOnEnter
    autocmd!
    autocmd WinEnter * call ResizeWindowForBuffer(s:term_buf, s:term_height)
augroup END
