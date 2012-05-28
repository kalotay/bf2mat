function mat_program = bf2mat(bf_program)
bf_elements = {'>', '<', '+', '-', ',', '.', '[', ']'};
mat_elements = {'x = x + 1; ' ...
    , 'x = x - 1; ' ...
    , 'A(x) = A(x) + 1; ' ...
    , 'A(x) = A(x) - 1; ' ...
    , 'y=[];while isempty(y), y=input('''',''s'');end A(x)=y(1); ' ...
    , 'fprintf(A(x)); ' ...
    , 'while A(x) ~= 0, ' ...
    , 'end; ' ...
    };
conversion_map = makearbitrarymap(bf_elements, mat_elements, '');
program_builder = util.map(conversion_map, bf_program);
mat_program = ['A = char(zeros(2 ^ 15, 1)); ' ...
    , 'x = 1; ' ...
    , 'y = []; ' ...
    , cat(2, program_builder{:}) ...
    ];
end