" Vim syntax file
" Language:	Python
" Author:	Matthew Simmons <matt.simmons@compbiol.org>
" Updated:	2018-06-19
"
" Derived from python.vim Samuel Hoffstaetter <samuel@hoffstaetter.com>

" Options to control Python syntax highlighting:
" For highlighted numbers:
"    let python_highlight_numbers = 1
" For highlighted builtin functions:
"    let python_highlight_builtins = 1
" For highlighted standard exceptions:
"    let python_highlight_exceptions = 1
" Highlight erroneous whitespace:
"    let python_highlight_space_errors = 1
"
" If you want all possible Python highlighting (the same as setting the
" preceding options):
"    let python_highlight_all = 1

syntax clear

setlocal foldmethod=syntax
" recommended:
" setlocal foldminlines=3

syntax keyword pythonStatement	break continue del exec pass raise as
syntax keyword pythonStatement	return with global assert lambda yield
syntax keyword pythonException	try except finally

syntax match pythonDefStatement	/^\s*\%(def \|class \)/ nextgroup=pythonFunction skipwhite
syntax match pythonFunction	"[a-zA-Z_][a-zA-Z0-9_]*" contained
syntax match pythonKeywordArg	"\v[\(\,]\s{-}\zs\w+\ze\s{-}\=(\=)@!"

" TODO: use old folding depending on an option
" syntax region pythonFunctionFold	start="^\z(\s*\)\%(def\|class\)\>"
"   \ end="\ze\%(\s*\n\)\+\%(\z1\s\)\@!." fold transparent

syntax region pythonFunctionFold	start="^\%(def\)\>"
  \ end="\%(\s*\n\)\{1,3}\ze\%(\s*\n\)*\%(\s\)\@!." fold transparent

syntax region pythonMethodFold	start="^\z(\s\+\)\%(def\)\>"
      \ end="\%(\s*\n\)\{1,2}\ze\%(\s*\n\)*\%(\z1\s\)\@!." fold transparent

syntax region pythonClassFold	start="^\z(\s*\)\%(class\)\>"
  \ end="\%(\s*\n\)\{1}\ze\%(\s*\n\)*\%(\z1\s\)\@!." fold transparent

syntax match   pythonComment /#\%(.\%({{{\|}}}\)\@!\)*$/
  \ contains=pythonTodo,@Spell
syntax region  pythonFold matchgroup=pythonComment
  \ start='#.*{{{.*$' end='#.*}}}.*$' fold transparent

syntax keyword pythonClassVar	self cls
syntax keyword pythonRepeat	for while
syntax keyword pythonConditional	if elif else
syntax keyword pythonOperator	and in is not or
" AS will be a keyword in Python 3
syntax keyword pythonImport	import from
syntax keyword pythonTodo		TODO FIXME XXX contained

" Decorators (new in Python 2.4)
syntax match   pythonDecorator	"@" display nextgroup=pythonFunction skipwhite

" strings
syntax region pythonString		start=+[uU]\='+ end=+'+ skip=+\\\\\|\\'+ contains=pythonEscape,@Spell
syntax region pythonString		start=+[uU]\="+ end=+"+ skip=+\\\\\|\\"+ contains=pythonEscape,@Spell
syntax region pythonDocString		start=+[uU]\="""+ end=+"""+ fold contains=pythonEscape,@Spell
syntax region pythonDocString		start=+[uU]\='''+ end=+'''+ fold contains=pythonEscape,@Spell
syntax region pythonRawString	start=+[uU]\=[rR]'+ end=+'+ skip=+\\\\\|\\'+ contains=@Spell
syntax region pythonRawString	start=+[uU]\=[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell
syntax region pythonRawString	start=+[uU]\=[rR]"""+ end=+"""+ contains=@Spell
syntax region pythonRawString	start=+[uU]\=[rR]'''+ end=+'''+ contains=@Spell
syntax match  pythonEscape		+\\[abfnrtv'"\\]+ contained
syntax match  pythonEscape		"\\\o\{1,3}" contained
syntax match  pythonEscape		"\\x\x\{2}" contained
syntax match  pythonEscape		"\(\\u\x\{4}\|\\U\x\{8}\)" contained
syntax match  pythonEscape		"\\$"

if exists('python_highlight_all')
  let python_highlight_numbers = 1
  let python_highlight_builtins = 1
  let python_highlight_exceptions = 1
  let python_highlight_space_errors = 1
  " let python_highlight_keyword_arguments = 1
endif

if exists('python_highlight_numbers')
  " numbers (including longs and complex)
  syntax match   pythonNumber	"\<0x\x\+[Ll]\=\>"
  syntax match   pythonNumber	"\<\d\+[LljJ]\=\>"
  syntax match   pythonNumber	"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
  syntax match   pythonNumber	"\<\d\+\.\([eE][+-]\=\d\+\)\=[jJ]\=\>"
  syntax match   pythonNumber	"\<\d\+\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
endif

if exists('python_highlight_builtins')
  " builtin functions, types and objects, not really part of the syntax
  syntax keyword pythonBuiltin	True False bool enumerate set frozenset help
  syntax keyword pythonBuiltin	reversed sorted sum print any all next
  syntax keyword pythonBuiltin	Ellipsis None NotImplemented __import__ abs
  syntax keyword pythonBuiltin	apply buffer callable chr classmethod cmp
  syntax keyword pythonBuiltin	coerce compile complex delattr dict dir divmod
  syntax keyword pythonBuiltin	eval execfile file filter float getattr globals
  syntax keyword pythonBuiltin	hasattr hash hex id input int intern isinstance
  syntax keyword pythonBuiltin	issubclass iter len list locals long map max
  syntax keyword pythonBuiltin	min object oct open ord pow property range
  syntax keyword pythonBuiltin	raw_input reduce reload repr round setattr
  syntax keyword pythonBuiltin	slice staticmethod str super tuple type unichr
  syntax keyword pythonBuiltin	unicode vars xrange zip
endif

if exists('python_highlight_exceptions')
  " builtin exceptions and warnings
  syntax keyword pythonException	ArithmeticError AssertionError AttributeError
  syntax keyword pythonException	DeprecationWarning EOFError EnvironmentError
  syntax keyword pythonException	Exception FloatingPointError IOError
  syntax keyword pythonException	ImportError IndentationError IndexError
  syntax keyword pythonException	KeyError KeyboardInterrupt LookupError
  syntax keyword pythonException	MemoryError NameError NotImplementedError
  syntax keyword pythonException	OSError OverflowError OverflowWarning
  syntax keyword pythonException	ReferenceError RuntimeError RuntimeWarning
  syntax keyword pythonException	StandardError StopIteration SyntaxError
  syntax keyword pythonException	SyntaxWarning SystemError SystemExit TabError
  syntax keyword pythonException	TypeError UnboundLocalError UnicodeError
  syntax keyword pythonException	UnicodeEncodeError UnicodeDecodeError
  syntax keyword pythonException	UnicodeTranslateError
  syntax keyword pythonException	UserWarning ValueError Warning WindowsError
  syntax keyword pythonException	ZeroDivisionError
endif

if exists('python_highlight_space_errors')
  " trailing whitespace
  syntax match   pythonSpaceError   display excludenl "\S\s\+$"ms=s+1
  " mixed tabs and spaces
  syntax match   pythonSpaceError   display " \+\t"
  syntax match   pythonSpaceError   display "\t\+ "
endif

" This is fast but code inside triple quoted strings screws it up. It
" is impossible to fix because the only way to know if you are inside a
" triple quoted string is to start from the beginning of the file. If
" you have a fast machine you can try uncommenting the "sync minlines"
" and commenting out the rest.
"syntax sync match pythonSync grouphere NONE "):$"
"syntax sync maxlines=200
syntax sync minlines=2000
syntax sync linebreaks=1

if version >= 508 || !exists("did_python_syn_inits")
  if version <= 508
    let did_python_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink pythonStatement	Statement
  HiLink pythonDefStatement	Statement
  HiLink pythonFunction		Function
  HiLink pythonConditional	Conditional
  HiLink pythonRepeat		Repeat
  HiLink pythonString		String
  HiLink pythonDocString		Comment
  HiLink pythonRawString	String
  HiLink pythonEscape		Special
  HiLink pythonOperator		Operator
  HiLink pythonImport		Include
  HiLink pythonComment		Comment
  HiLink pythonTodo		Todo
  HiLink pythonDecorator	Define
  HiLink pythonClassVar		Identifier
  if exists('python_highlight_numbers')
    HiLink pythonNumber	Number
  endif
  if exists('python_highlight_builtins')
    HiLink pythonBuiltin	Function
  endif
  if exists('python_highlight_exceptions')
    HiLink pythonException	Exception
  endif
  if exists('python_highlight_space_errors')
    HiLink pythonSpaceError	Error
  endif
  if exists('python_highlight_keyword_arguments')
    HiLink pythonKeywordArg	Keyword
  endif

  delcommand HiLink
endif

let b:current_syntax = 'python'
