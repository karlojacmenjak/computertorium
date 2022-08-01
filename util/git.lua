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

function list()
    get_response = http.get("https://api.github.com/repos/zpqrtbnk/test-repo/contents")
    for k, v in pairs(get_response) do
        print(k,v)
    end
    print(textutils.serialize(textutils.unserializeJSON(get_response["readAll"]())))
    --print(textutils.serialize(get_response["readAll"]())) 
    local file = fs.open("out.txt", "w")
    file.write(get_response["readAll"]())
    file.close()
    get_response["close"]()
end

function grab(filepath)
    filepath = filepath or ""
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

