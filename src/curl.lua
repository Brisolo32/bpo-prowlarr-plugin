local http = { _version = "0.0.1" }

-- Function to make an HTTP request using curl
function http.request(url, method, headers)
    -- Construct the curl command
    local command = "curl -X ".. method .. " -s"

	-- Add the URL to the command
	command = command .. " \"" .. url .. "\""

	if headers ~= nil then
		-- Add headers to the command
		for key, value in pairs(headers) do
			command = command .. " -H '" .. key .. ": " .. value .. "'"
		end
    end

    -- Execute the command and capture the output
    local handle = assert(io.popen(command, "r"))
    local response = handle:read("*a")
    handle:close()

    -- Return the response
    return response
end

return http
