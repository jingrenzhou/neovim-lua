" Import Lua modules
lua require ("init")

" import vim
" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Leaderf
" === LeaderF

" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "ff"
noremap ge :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", expand("<cword>"))<CR><CR>
" search visually selected text literally
xnoremap gv :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR><CR>
noremap go :<C-U>Leaderf! rg --recall<CR>
