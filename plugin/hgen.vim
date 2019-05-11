
function! g:HGen()
    let nb_lines = line("$")
    let i = 1
    let open = 0
    let current_is_static = 0
    let functions = []
    let name = expand("%:t")[0:-3]
    call add(functions, "#ifndef _".toupper(name)."_H_")
    call add(functions, "#define _".toupper(name)."_H_")
    while i <= nb_lines
        let current_line = getline(i)
        if len(current_line) > 0 && split(current_line)[0] == 'static'
            let current_is_static = 1
        endif

        if ((current_line == '/* [start]') || (current_line == '/*[start]'))
            let struct_line = getline(i + 1)
            while ((struct_line != "[end] */") && (struct_line != "[end]*/"))
                call add(functions, struct_line)
                let i = i + 1
                let struct_line = getline(i + 1)
            endwhile
            let i = i + 1
        elseif open == 0 && len(current_line) > 0 && !current_is_static
            if current_line[len(current_line)-1] == '{'
                call add(functions, current_line[0:-2].';')
                call add(functions, "")
            else
                call add(functions, current_line)
            endif
        endif
        if HasOpenCurlyBrak(current_line)
            let open = open + 1
        endif
        if HasCloseCurlyBrak(current_line)
            let open = open - 1
            if open == 0 && current_is_static
                let current_is_static = 0
            endif
        endif
        let i = i + 1
    endwhile
    call add(functions, "#endif")
    exec "silent pedit ".expand("%")[0:-3].".h"
    wincmd P
    normal! ggvGd
    call append(0, functions)
endfunction

function! HasChar(line_content, char)
    let i = 0
    while i < strlen(a:line_content)
        let c = a:line_content[i]
        if c == a:char
            return 1
        endif
        let i = i + 1
    endwhile
    return 0
endfunction

function! HasOpenCurlyBrak(line_content)
    return HasChar(a:line_content, "{")
endfunction

function! HasCloseCurlyBrak(line_content)
    return HasChar(a:line_content, "}")
endfunction

command! Hgen call HGen()
