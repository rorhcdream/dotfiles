let s:term_buf = 0
let s:term_height = 20
let s:last_window = 0
let g:term_insert_mode = 1

nmap <Plug>TermToggle :call <SID>TermToggle()<CR>
imap <Plug>TermToggle <Plug>esc:call <SID>TermToggle()<CR>
tmap <Plug>TermToggle <Plug>esc:let g:term_insert_mode=1<CR>:call <SID>TermToggle()<CR>

function! s:TermToggle()
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
        if g:term_insert_mode
            startinsert!
        endif
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
        if g:term_insert_mode == 1
            startinsert!
        endif
    endif
endfunction

function! s:OnModeChanged()
    if bufnr('%') == s:term_buf
        if v:event['old_mode'] == 't' && v:event['new_mode'] == 'nt'
            let g:term_insert_mode = 0
        elseif v:event['new_mode'] == 't'
            let g:term_insert_mode = 1
        endif
    endif
endfunction

augroup ResizeTermWindowOnEnter
    autocmd!
    autocmd WinEnter * call <SID>OnWinEnter()
    autocmd ModeChanged * call <SID>OnModeChanged()
augroup END
