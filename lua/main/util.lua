function dump(o)
    if type(o) == 'table' then
        local ret = '{ '
        local p = ''
        for key,val in pairs(o) do
            if type(key) == 'number' then
                key = ''
            else
                key = '"' ..key.. '" = '
            end
            ret = ret .. p .. key .. dump(val)
            p = ', '
        end
        return ret .. ' } '
    else
        return tostring(o)
    end
end

