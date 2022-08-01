local easings = {}
function easings.easeInCirc(x)
    return (1 - math.sqrt(1 - x^2))
end

return easings