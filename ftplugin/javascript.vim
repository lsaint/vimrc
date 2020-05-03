" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['eslint', 'prettier']

nmap <leader>1 :Ack! --js --ignore "node_modules*" -s -w <C-r><C-w><cr>
