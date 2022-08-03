
git_link = "https://raw.githubusercontent.com/karlojacmenjak/computertorium/"
git_path = "test/"
version_pattern = "%d%.%d+"

local function get_versions()
    versions = {} for c in string.gmatch(_HOST, version_pattern) do table.insert(versions, c) end
    return versions
end

if #fs.find(git_path) == 0 then
    print("No previous install found, making new install...")
    fs.makeDir(git_path)
    local response = http.get("https://raw.githubusercontent.com/karlojacmenjak/computertorium/main/util/git/git.lua")
    local file = fs.open(git_path.."git.lua","w")
    file.write(response["readAll"]())
    file.close()
end


--first_install()

print(textutils.serialize(get_versions()))
