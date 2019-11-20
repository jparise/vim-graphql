"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: TSX (TypeScript)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" These are the plugin-to-syntax-element correspondences:
"   - leafgarland/typescript-vim:             typescriptFuncBlock


let s:tsx_cpo = &cpo
set cpo&vim

syntax case match

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

syn include @HTMLSyntax syntax/html.vim
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

"""""" Vim Syntax Help """"""
" `keepend` and `extend` docs:
" https://github.com/othree/til/blob/master/vim/syntax-keepend-extend.md

" \@<=    positive lokbehind
" \@<!    negative lookbehind
" \@=     positive lookahead
" \@!     negative lookahead



syntax case match

"  <tag></tag>
" s~~~~~~~~~~~e
syntax region tsxRegion
    \ start=+\(\([a-zA-Z]\)\@<!<>\|\(\s\|[(]\s*\)\@<=\z(<[/a-zA-Z],\@!\([a-zA-Z0-9:\-],\@!\)*\)\)+
    \ skip=+<!--\_.\{-}-->+
    \ end=+</\_.\{-}>+
    \ end=+[a-zA-Z0-9.]*[/]*>\s*\n*\s*\n*\s*[});,]\@=+
    \ contains=tsxTag,tsxCloseTag,tsxComment,Comment,@Spell,tsxColon,tsxIfOperator,tsxElseOperator,jsBlock
    \ extend
    \ keepend



" Negative lookbacks for:
" <> preceeded by [a-zA-Z]
" <<Tag...
" [a-zA-Z]<Tag

" end 1): handle </NormalClosingTag>
" end 2): handle <SelfClosingTags/>\s*\n*\s*\n*\s*)
" \s => spaces/tabs
" \n => end-of-line => \n only match end of line in the buffer.
" \s*\n*\s*\n*\s* => handles arbitrary spacing between closing tsxTag </tag>
" and the ending brace for the scope: `}` or `)`
"
" \z( pattern \) Braces can be used to make a pattern into an atom.

" <tag>{content}</tag>
"      s~~~~~~~e
syn region jsBlock
    \ start=+{+
    \ end=+}+
    \ contained
    \ contains=TOP

" \@<=    positive lookbehind
" \@<!    negative lookbehind
" \@=     positive lookahead
" \@!     negative lookahead
" RULE: capture expression, then apply rule AFTER
" e.g foo\(bar\)\@!
" match all `foo` which is not followed by `bar`
" https://jbodah.github.io/blog/2016/11/01/positivenegative-lookaheadlookbehind-vim/

" <tag key={this.props.key}>
"          s~~~~~~~~~~~~~~e
syntax region tsxJsBlock
    \ matchgroup=tsxAttributeBraces start=+\([=]\|\s\)\@<={+
    \ matchgroup=tsxAttributeBraces end=+}\(\s*}\|)\)\@!+
    \ contained
    \ keepend
    \ extend
    \ contains=TOP

" <tag id="sample">
" s~~~~~~~~~~~~~~~e
syntax region tsxTag
      \ start=+<[^ /!?<"'=:]\@=+
      \ end=+[/]\{0,1}>+
      \ contained
      \ contains=tsxTagName,tsxAttrib,tsxEqual,tsxString,tsxJsBlock,tsxAttributeComment,jsBlock,tsxGenerics

syntax region tsxGenerics
    \ matchgroup=tsxTypeBraces start=+\([<][_\-\.:a-zA-Z0-9]*\|[<][_\-\.:a-zA-Z0-9]*\)\@<=\s*[<]+
    \ matchgroup=tsxTypeBraces end=+>+
    \ contains=tsxTypes,tsxGenerics
    \ contained
    \ extend

syntax match tsxTypes /[_\.a-zA-Z0-9]/
    \ contained

" \@<!    negative lookbehind

"  <T1, T2>
" s~~~~~~~e
" For Generics outside of tsxRegion
" Must come after tsxRegion in this file
syntax region tsGenerics
    \ start=+<\([\[A-Z]\|typeof\)\([a-zA-Z0-9,{}\[\]'".=>():]\|\s\)*>\(\s*\n*\s*[()]\|\s*[=]\)+
    \ end=+\([=]\)\@<!>+
    \ contains=tsxTypes,tsxGenerics
    \ extend

" </tag>
" ~~~~~~
syntax region tsxCloseTag
      \ start=+</[^ /!?<"'=:]\@=+
      \ end=+>+
      \ contained
      \ contains=tsxCloseString

" matches tsx Comments: {/* .....  /*}
syn region Comment contained start=+{/\*+ end=+\*/}+ contains=Comment
  \ extend

syn region tsxAttributeComment contained start=+//+ end=+\n+ contains=Comment
  \ extend

syntax match tsxCloseString
    \ +\w\++
    \ contained

syntax match tsxColon
    \ +[;]+
    \ contained

" <!-- -->
" ~~~~~~~~
syntax match tsxComment /<!--\_.\{-}-->/ display
syntax match tsxEntity "&[^; \t]*;" contains=tsxEntityPunct
syntax match tsxEntityPunct contained "[&.;]"

" <tag key={this.props.key}>
"  ~~~
syntax match tsxTagName
    \ +[<]\@<=[^ /!?<>"']\++
    \ contained
    \ display

" <tag key={this.props.key}>
"      ~~~
syntax match tsxAttrib
    \ +[-'"<]\@<!\<[a-zA-Z:_][-.0-9a-zA-Z0-9:_]*[/]\{0,1}\>\(['"]\@!\|$\)+
    \ contained
    \ keepend
    \ contains=tsxAttribPunct,tsxAttribHook
    \ display

syntax match tsxAttribPunct +[:.]+ contained display

" <tag id="sample">
"        ~
syntax match tsxEqual +=+ contained display

" <tag id="sample">
"         s~~~~~~e
syntax region tsxString contained start=+"+ end=+"+ contains=tsxEntity,@Spell display

" <tag id=`sample${var}`>
syntax region tsxString contained start=+`+ end=+`+ contains=tsxEntity,@Spell display

" <tag id='sample'>
"         s~~~~~~e
syntax region tsxString contained start=+'+ end=+'+ contains=tsxEntity,@Spell display

syntax match tsxIfOperator +?+
syntax match tsxNotOperator +!+
syntax match tsxElseOperator +:+

" highlight def link tsxTagName htmlTagName
highlight def link tsxTagName xmlTagName
highlight def link tsxTag htmlTag
highlight def link tsxCloseTag xmlEndTag
highlight def link tsxRegionEnd xmlEndTag
highlight def link tsxEqual htmlTag
highlight def link tsxString String
highlight def link tsxNameSpace Function
highlight def link tsxComment Error
highlight def link tsxAttrib htmlArg
highlight def link tsxCloseString htmlTagName
highlight def link tsxAttributeBraces htmlTag
highlight def link tsxAttributeComment Comment
highlight def link tsxColon typescriptEndColons

highlight def link tsxGenerics typescriptEndColons
highlight def link tsGenerics tsxTypeBraces

highlight def link tsxIfOperator typescriptEndColons
highlight def link tsxNotOperator typescriptEndColons
highlight def link tsxElseOperator typescriptEndColons
highlight def link tsxTypeBraces htmlTag
highlight def link tsxTypes typescriptEndColons

" Custom React Highlights
syn keyword ReactState state nextState prevState setState
" Then EITHER (define your own colour scheme):
" OR (make the colour scheme match an existing one):
" hi link ReactKeywords typescriptRComponent
syn keyword ReactProps props defaultProps ownProps nextProps prevProps
syn keyword Events e event target value
syn keyword ReduxKeywords dispatch payload
syn keyword ReduxHooksKeywords useState useEffect useMemo useCallback
syn keyword WebBrowser window localStorage
syn keyword ReactLifeCycleMethods componentWillMount shouldComponentUpdate componentWillUpdate componentDidUpdate componentWillReceiveProps componentWillUnmount componentDidMount

let b:current_syntax = 'typescript.tsx'

" GraphQL Support 
if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif
syn include @GraphQLSyntax syntax/graphql.vim
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

let s:tags = '\%(' . join(graphql#javascript_tags(), '\|') . '\)'

exec 'syntax region graphqlTemplateString start=+' . s:tags . '\@20<=`+ skip=+\\`+ end=+`+ contains=@GraphQLSyntax,typescriptTemplateSubstitution extend'
exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'

" Support expression interpolation ((${...})) inside template strings.
syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=typescriptTemplateSubstitution containedin=graphqlFold keepend

hi def link graphqlTemplateString typescriptTemplate
hi def link graphqlTemplateExpression typescriptTemplateSubstitution

syn cluster typescriptExpression add=graphqlTaggedTemplate
syn cluster graphqlTaggedTemplate add=graphqlTemplateString

let &cpo = s:tsx_cpo
unlet s:tsx_cpoo
