if exists('b:current_syntax') && b:current_syntax == 'fish'
  finish
endif

" Fish syntax is pretty versatile
setlocal isident+=`@%^&

syn match fishStatement /\v<%(return|break|continue)/
syn match fishBlock /\v<%(if|else|for|function|switch|case|begin|end>/

if !exists('b:current_syntax')
  let b:current_syntax = 'fish'
endif
