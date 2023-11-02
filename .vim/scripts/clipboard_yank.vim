augroup ClipboardYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | let @+ = @0 | endif
augroup END
