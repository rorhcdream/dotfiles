let s:last_clipboard = @+

augroup ClipboardYank
    autocmd!
    autocmd TextYankPost *
        \ if v:event.operator ==# 'y' |
        \ let @+ = @0 |
        \ let s:last_clipboard = @0 |
        \ endif
    autocmd FocusGained *
        \ if @+ != s:last_clipboard |
        \ let @0 = @+ |
        \ let @" = @+ |
        \ let s:last_clipboard = @+ |
        \ endif
augroup END
