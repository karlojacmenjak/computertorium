--https://docs.github.com/en/rest/repos/contents
ccrings = require("cc.strings")
easings = require("easings")
args = {...}

git_api = {link = function (repo,folder) return string.format("https://api.github.com/repos/%s/contents/%s",repo, folder) end}
git_url = "https://raw.githubusercontent.com/"
repository = "zpqrtbnk/test-repo"

local function setup()
    folder = folder or ""
    get_response = http.get(git_api["link"](repository,folder))
    for k, v in pairs(get_response) do
        print(k,v)
    end
    textutils.slowPrint(textutils.serialize(textutils.unserializeJSON(get_response["readAll"]())))
    get_response["close"]()
end

function version()
    print("Git version 0.0.1")
end

function list(repo, folder)
    local get_response = http.get(git_api["link"](repo or repository,folder or ""))
    local repo_files = textutils.unserializeJSON(get_response["readAll"]())
    local termx, termy = term.getSize()
    local ysize = termy
    print("No. of entries: ",#repo_files)
    for k, v in pairs(repo_files) do
        if k < ysize-1 then
            text_table = {string.char(28).." "..v["name"]}
            for i=2, termx-string.len(text_table[1])-string.len(v["type"]), 1 do
                text_table[i] = " "
            end
            table.insert(text_table, v["type"])
            text =  table.concat(text_table)
            print(text)
        else
            print("------SPACE for MORE------")
            while true do
                local _, key, is_held = os.pullEvent("key")
                ysize = termy + ysize
                if keys.getName(key) == "space" and not is_held then 
                    x,y = term.getCursorPos()
                    term.setCursorPos(x,y-1)
                    term.clearLine()
                    break 
                end
            end
        end
        sleep(easings.easeInCirc((k/#repo_files))/2)
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

