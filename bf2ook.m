function ook_program = bf2ook(bf_program, prefix)
if nargin < 2
    prefix = 'Ook';
end
ook_elements = {'.?', '?.', '..', '!!', '.!', '!.', '!?', '?!'};
bf_elements = {'>', '<', '+', '-', ',', '.', '[', ']'};
conversion_map = makearbitrarymap(bf_elements ...
    , util.map(@(suffix)[prefix ...
    , suffix(1) ...
    , ' ' ...
    , prefix ...
    , suffix(2) ...
    , ' '  ...
    ], ook_elements) ...
    , '' ...
    );
program_builder = util.map(conversion_map, bf_program);
ook_program = cat(2, program_builder{:});
end