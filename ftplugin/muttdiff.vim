let b:did_ftplugin = 1

let b:undo_ftplugin = "setl modeline< tw< fo<"

" many people recommend keeping e-mail messages 72 chars wide
if &tw == 0
  setlocal tw=72
endif

" Set 'formatoptions' to break text lines and keep the comment leader ">".
setlocal fo+=tcql
