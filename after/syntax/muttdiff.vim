syn match mailQuote "^>* "
syn match mailQuotedDeletion "^>* *-.*" contains=mailQuote
syn match mailQuotedAddition "^>* *+.*" contains=mailQuote

syn match mailQuote2 "^>>* [^-+].*"

hi def link mailQuote2 Comment
hi def link mailQuotedDeletion Special
hi def link mailQuotedAddition Identifier
