function value = getarbitrarymap(arbitrary_map, key, default_value)
if nargin < 3
    default_value = [];
end
found_indexes = strcmp(key, {arbitrary_map.key});
map_index = find(found_indexes);
if isempty(map_index)
    value = default_value;
else
    value = arbitrary_map(map_index(1)).value;
end
end
