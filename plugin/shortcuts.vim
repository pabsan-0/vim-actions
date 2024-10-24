let g:actions_echom_prefix = '[actions.vim] '

" Check that fzf.vim is installed
if match(&runtimepath, 'fzf.vim') == -1
    echom g:actions_echom_prefix . "fzf.vim not found! Loading anyway, do expect issues." 
endif


" Quick access list default
" - Left side of separator is (Action) Name 
" - Right side of separator is Target
let g:actions_list = [
    \ ["Source local rc       | :source .vimrc "],
    \ ["Edit local rc         | :edit .vimrc   "],
    \ ["                                       "],
    \ [".gitconfig            | ~/.gitconfig   "],
    \ [".vimrc                | ~/.vimrc       "],
    \ ["                                       "],
    \ ]


" Entrypoint. Loads action list and feeds into FZF 
command! Actions call fzf#run(fzf#wrap({
    \ 'source': map(copy(g:actions_list), 'v:val[0]'),
    \ 'sink*': function('ActionsFZFHandle')
    \ }))


" Sink function for FZF. Actions after selection is made 
function! ActionsFZFHandle(selected)
   
    " Check that separator is present between action name and target
    if a:selected[0]!~'|'
        return
    endif

    " Discard action name through separator, keep target only 
    let l:target = split(a:selected[0], "|")[-1]
    
    " Remove trailing/leading whitespace and expand for chars like ~ 
    let l:target = substitute(l:target, '\s*$', '', '')
    let l:target = substitute(l:target, '^\s*', '', '')
    let l:target = expand(l:target)

    " Handle target by type: may be a command, file or directory
    if l:target =~ ':'
        echom "Executing command: " . l:target
        execute l:target
    elseif isdirectory(l:target)
        tabnew
        execute 'cd ' . fnameescape(l:target)
        execute 'Explore'
    elseif filereadable(l:target)
        tabnew
        execute 'edit ' . fnameescape(l:target)
    else
        let l:create = confirm("File " . l:target . " does not exist. Create it?", "&Yes\n&No", 1)
        if l:create == 1
            tabnew
            execute 'edit ' . fnameescape(l:target)
        endif
    endif
endfunction


" Quickly populate local rcfiles with actions lists
function! ActionsTemplateExtend()
    let s:plugin_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    execute 'read ' . fnameescape(s:plugin_path . '/samples/.vimrc-extend')
endfunction
command! ActionsTemplateExtend call ActionsTemplateExtend()


function! ActionsTemplateReplace()
    let s:plugin_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    execute 'read ' . fnameescape(s:plugin_path . '/samples/.vimrc-replace')
endfunction
command! ActionsTemplateReplace call ActionsTemplateReplace()


" Key mapping to invoke the Action command, only if not being used
if mapcheck("<leader>q", "I") == "" 
    nnoremap <leader>q :Actions <CR>
endif
