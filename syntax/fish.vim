if exists('b:current_syntax') && b:current_syntax == 'fish'
	finish
endif

" Fish syntax is pretty versatile
setlocal iskeyword+=`

syn match fishComment /\v\#.*$/
syn match fishShebang /\v\#!.*$/

" Must be first so that statement highlighting trumps command highlighting
syn match fishCommand /\v<[^[:space:];$]+>/ contained
syn match fishInnerCommand /\v\(@<=[^[:space:];$()]+/ contained
syn region fishFor matchgroup=fishStatement start=/for/ end=/in/ contained contains=fishCommandSubstitution,fishVar,fishQuote
syn region fishFor matchgroup=fishStatement start=/\v<for>/ end=/\v<in>/ contained contains=fishCommandSubstitution,fishVar,fishQuote

syn match fishLine /^\s*/ nextgroup=fishStatement,fishCommand,fishComment,fishShebang,fishFor skipWhite
syn match fishStatement /\v<%(if|function|switch|case)>/ nextgroup=fishCommand skipwhite
syn match fishStatement /\v<%(else)>/ nextgroup=fishStatement,fishCommand skipwhite
syn match fishStatement /\v<%(return|break|continue|begin|end)>/
syn match fishSemicolon /;/ nextgroup=fishStatement,fishFor,fishCommand skipwhite

syn match fishFlag /\v(^|\s)@<=-(\w|-|_)+>/
syn match fishFlag /\v(^|\s)@<=--(\w|-|_)+>/
syn match fishRedirect /\v%(\d?\>|\^|\>\>|\^\^)(\s*\&%(\d|-))?/

syn match fishVar /\v\$(\w|_)+/ nextgroup=fishSlice
syn region fishSlice matchgroup=fishBracket start=/\v\[/ end=/\v\]/ contained contains=fishNumber,fishRange,fishCommandSubstitution,fishVar
syn match fishNumber /\v\d+/ contained
syn match fishRange /\v\.\./ contained

syn match fishEscapeSingleQuote /\v(\\'|\\\\)/ contained
syn match fishEscape /\\./

syn region fishQuote start=/'/ end=/'/ skip=/\v\\'/ contains=fishEscapeSingleQuote
syn region fishQuote start=/"/ end=/"/ skip=/\v\\"/ contains=fishVar,fishEscape

syn region fishCommandSubstitution matchgroup=fishParen start=/\v\(/ end=/\v\)/ contains=fishInnerCommand,fishStatement,fishFor,fishCommandSubstitution,fishFlag,fishRedirect,fishVar,fishQuote,fishSemicolon

hi def link fishCommand Macro
hi def link fishInnerCommand Macro
hi def link fishStatement Statement
hi def link fishSemicolon Statement
hi def link fishFlag Type
hi def link fishRedirect Type
hi def link fishNumber Constant
hi def link fishVar Identifier
hi def link fishQuote Constant
hi def link fishEscape Special
hi def link fishEscapeSingleQuote Special
hi def link fishComment Comment
hi def link fishShebang Special

hi def link fishParen Type
hi def link fishBracket Type
hi def link fishRange Type

if !exists('b:current_syntax')
	let b:current_syntax = 'fish'
endif
