# Override fish's builtin ll (ls -lh) to also show hidden files.
function ll --wraps ls --description 'List long format, including hidden files'
    ls -lha $argv
end
