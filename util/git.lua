--https://docs.github.com/en/rest/repos/contents
ccrings = require("cc.strings")
args = {...}

git_api = {link = function (repo,folder) return string.format("https://api.github.com/repos/%s/contents/%s",repo, folder) end}
git_url = "https://raw.githubusercontent.com/"
repository = "zpqrtbnk/test-repo"

local function setup()
    for i=0,255,1 do
        print(i,string.char(i))
        sleep(0.3)
    end
end

function version()
    print("Git version 0.0.1")
end

function list(repo, folder)
    repo = repo or repository
    folder = folder or ""
    get_response = http.get(git_api["link"](repo,folder))
    repo_files = textutils.unserializeJSON(get_response["readAll"]())
    for k, v in pairs(repo_files) do
        text_table = {string.char(28).." "..v["name"]}
        for i=2, term.getSize()-string.len(text_table[1])-string.len(v["type"]), 1 do
            text_table[i] = " "
        end
        table.insert(text_table, v["type"])
        text =  table.concat(text_table)
        print(text)
        sleep(math.log(#repo_files))
    end
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

--setup()

for key, value in pairs(args) do
    if value ~= nil then
        gcall(value, args[key+1])
    end
end

