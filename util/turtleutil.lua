local turtleutil = {}

function turtleutil.findItem(item, similar)
    item = item or nil
    regex = similar or nil
    slot = 0
    if not (item and similar) then
           error("Values for \"item\" or \"similar\" not provided",2)
    end
    for i=1, 15 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == item then
                turtle.select(i)
                slot = i
            end
            if similar then
                if string.find(turtle.getItemDetail(i).name, similar) then
                    turtle.select(i)
                    slot = i
                end
            end
        end
    end
    return slot
end

return turtleutil