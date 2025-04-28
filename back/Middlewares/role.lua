return function(data, role)
    if data.role == role then
        return true
    end
    return false
end