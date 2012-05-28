function bfrepl(bf_program)
if nargin < 1
    bf_program = '';
end
tape = char(zeros(1, 2 ^ 16));
tape_pointer = 1;
open_stack = zeros(2 ^ 14, 1);
open_stack_pointer = 0;
user_input = '';
program = char(zeros(1, 2 ^ 16));
program(1:numel(bf_program)) = bf_program(:);
program_size = numel(program);
program_pointer = 0;
input_prompt = '\n.. ';
nested_prompt = '\n[[ ';

while program_pointer < program_size
    program_pointer = program_pointer + 1;
    element = program(program_pointer);
    switch element
        case char(0)
            if open_stack_pointer == 0
                prompt = input_prompt;
            else
                prompt = nested_prompt;
            end
            user_program = input(prompt, 's');
            program((1:numel(user_program)) + program_pointer - 1) = ...
                user_program;
            program_pointer = program_pointer - 1;
        case '>'
            tape_pointer = tape_pointer + 1;
        case '<'
            tape_pointer = tape_pointer - 1;
        case '+'
            tape(tape_pointer) = tape(tape_pointer) + 1;
        case '-'
            tape(tape_pointer) = tape(tape_pointer) - 1;
        case '.'
            fprintf(tape(tape_pointer));
        case ','
            while isempty(user_input)
                user_input = input('\n,, ', 's');
                tape(tape_pointer) = user_input(1);
            end
            user_input = '';
        case '['
            if tape(tape_pointer) == 0
                
                while program(program_pointer) ~= ']'
                    program_pointer = program_pointer + 1;
                    if program(program_pointer) == char(0)
                        program_pointer = program_pointer - 1;
                        if open_stack_pointer == 0
                            prompt = input_prompt;
                        else
                            prompt = nested_prompt;
                        end
                        user_program = input(prompt, 's');
                        program((1:numel(user_program)) + program_pointer - 1) = ...
                            user_program;
                    end
                end
            else
                open_stack_pointer = open_stack_pointer + 1;
                open_stack(open_stack_pointer) = program_pointer;
            end
        case ']'
            if tape(tape_pointer) == 0
                open_stack_pointer = open_stack_pointer - 1;
            else
                program_pointer = open_stack(open_stack_pointer);
            end
        case 'q'
            return;
    end
end
