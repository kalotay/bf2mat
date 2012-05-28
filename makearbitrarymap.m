function arbitrary_map = makearbitrarymap(keys, values)
%Matlab sucks for associative arrays.
arbitrary_map = cell2struct([keys; values], {'key', 'value'}, 1);
end
