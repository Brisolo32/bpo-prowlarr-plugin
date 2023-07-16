local http = require("curl")
local json = require("json")

-- Makes a http request to the Prowlarr server running locally
local headers = {
    ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) ApplWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1788.0",
    ["Accept"] = "application/json, text/javascript, */*; q=0.01",
    ["Referer"] = "http://localhost:9696/search",
    ["X-Api-Key"] = "51ad74b9abc549c0b4933374db3578ad",
    ["X-Prowlarr-Client"] = "true",
    ["X-Requested-With"] = "XMLHttpRequest",
    ["Connection"] = "keep-alive",
    ["Sec-Fetch-Mode"] = "cors",
    ["Sec-Fetch-Dest"] = "empty",
    ["Sec-Fetch-Site"] = "same-origin"
}

local query_fixed = string.gsub(Query, "%s", "-")

-- The URL to the Prowlarr server (default is localhost:9696)
local url = "http://localhost:9696/api/v1/search?query=" .. query_fixed .. "&type=search&limit=20&offset=0"

local request = http.request(url, "GET", headers)

-- Now the real stuff begins :)
local ret_val = {}
local request_dec = json.decode(request)

for _,v in pairs(request_dec) do
    table.insert(ret_val, {
        name = v.title,
        links = {
            { link = v.downloadUrl },
            { link = v.infoUrl }
        }
    })
end

PluginReturn = json.encode(ret_val)
