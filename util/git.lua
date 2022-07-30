args = {...}
--https://docs.github.com/en/rest/repos/contents

git_url = "https://raw.githubusercontent.com/"
repository = "zpqrtbnk/test-repo/"

local function setup()
    --print(textutils.serialize(settings.getNames()))
end

function version()
    print("Git version 0.0.1")
end


function grab(filepath)
    get_response = http.get("https://github.com/zpqrtbnk/test-repo/blob/master/test.txt")
    for k, v in pairs(get_response) do
        print(k,v)
    end
    print(get_response["getResponseCode"]())
    get_response["close"]()
    shell.run("wget", git_url..repository..filepath)
end

function gcall(command, parameter)
    --calls function by string from global enviorment, cannot call 'local' functions!
    if getfenv()[command] then
        getfenv()[command](parameter)
    end
end

setup()

for key, value in pairs(args) do
    if value ~= nil then
        gcall(value, args[key+1])
    end
end

