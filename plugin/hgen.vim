
function! g:HGen()
    let nb_lines = line('$')
    let i = 1
    let open = 0
    let functions = []
    let name = expand('%:t')[0:-3]
    call add(functions, '#ifndef _'.toupper(name).'_H_')
    call add(functions, '#define _'.toupper(name).'_H_')
    while i <= nb_lines
        let current_line = getline(i)
        if HasOpenCurlyBrak(current_line)
            if open == 0
                call add(functions, current_line[0:-2].';')
            endif
            let open = open + 1
        endif
        if HasCloseCurlyBrak(current_line)
            let open = open - 1
        endif
        let i = i + 1
    endwhile
    call add(functions, '#endif')
    exec 'silent pedit '.name.'.h'
    wincmd P
    normal! ggvGd
    call append(0, functions)
endfunction

function! HasOpenCurlyBrak(line_content)
    let i = 0
    while i < strlen(a:line_content)
        let c = a:line_content[i]
        if c == '{'
            return 1
        endif
        let i = i + 1
    endwhile
    return 0
endfunction

function! HasCloseCurlyBrak(line_content)
    let i = 0
    while i < strlen(a:line_content)
        let c = a:line_content[i]
        if c == '}'
            return 1
        endif
        let i = i + 1
    endwhile
    return 0
endfunction

command! Hgen call HGen()
