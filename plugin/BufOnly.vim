command! -nargs=? -complete=buffer -bang Bonly
      \ :call BuffOnly('<args>', '<bang>')

command! -nargs=? -complete=buffer -bang BOnly
      \ :call BuffOnly('<args>', '<bang>')

command! -nargs=? -complete=buffer -bang Bufonly
      \ :call BuffOnly('<args>', '<bang>')

command! -nargs=? -complete=buffer -bang BufOnly
      \ :call BuffOnly('<args>', '<bang>')

function! BuffOnly(buffer, bang)
  if a:buffer == ''
    "no buffer provided, use the current buffer
    let buffer = bufnr('%')
  elseif (a:buffer + 0) > 0
    "a buffer number was provided
    let buffer = bufnr(a:buffer + 0)
  else
    "a buffer name was provided
    let buffer = bufnr(a:buffer)
  endif

  if buffer == 1
    echohl ErrorMsg
    echomsg "No matching buffer for " a:buffer
    echohl None
    return
  end

  let last_buffer = bufnr('$')
  let delete_count = 0
  let n = 1

  while n <= last_buffer
    if n != buffer && buflisted(n)
      if a:bang == '' && getbufvar(n, '&modified')
        echohl ErrorMsg
        echomsg 'No write since last change for buffer '
              \ n ' (add ! to override)'
        echohl None
      else
        silent exe 'bdel' . a:bang . ' ' . n
        if ! buflisted(n)
          let delete_count = delete_count + 1
        endif
      endif
    endif
    let n = n + 1
  endwhile

  if delete_count == 1
    echomsg delete_count " buffer deleted"
  else
    echomsg delete_count " buffers deleted"
  end
endfunction
