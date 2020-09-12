function _min(a, b)
    if math.abs(a) < math.abs(b) then return a end
    return b
end

function _max(a, b)
    if math.abs(a) > math.abs(b) then return a end
    return b
end