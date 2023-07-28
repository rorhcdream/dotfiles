let s:term_buf = 0
let s:term_height = 20
let s:last_window = 0

function! TermToggle()
    if win_gotoid(<SID>GetFirstWindowNumberForBuffer(s:term_buf))
        hide
        call win_gotoid(s:last_window)
    else
        let s:last_window = win_getid()
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

" function! s:GetLastWindowID()
"   return win_getid(winnr('#'))
" endfunction

function! s:GetFirstWindowNumberForBuffer(buffer_number)
    for win_info in getwininfo()
        if win_info['bufnr'] == a:buffer_number
            return win_info['winid']
        endif
    endfor
    return -1  " Return -1 if buffer is not open in any window
endfunction

function! s:OnWinEnter()
    if bufnr('%') == s:term_buf
        execute 'resize ' . s:term_height
    endif
endfunction

augroup ResizeTermWindowOnEnter
    autocmd!
    autocmd WinEnter * call <SID>OnWinEnter()
augroup END
