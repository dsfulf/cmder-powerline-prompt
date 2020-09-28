-- local clink_path_lua_file = clink.get_env('CMDER_ROOT')..'\\vendor\\clink-completions\\modules\\path.lua'
-- dofile(clink_path_lua_file)
function basename(path)
    local prefix = path
    local i = path:find("[\\/:][^\\/:]*$")
    if i then
        prefix = path:sub(i + 1)
    end
    return prefix
end

function get_virtual_env(env_var)
    local env = clink.get_env(env_var)
    if env then
        return basename(env)
    end
    return false
end

local function append_prompt(env_var)
    if env_var == "VIRTUAL_ENV" then
        local env_path = clink.get_env(env_var)
        if env_path then
            local i = clink.prompt.value:find(newLineSymbol)
            clink.prompt.value = clink.prompt.value:sub(0, i)
        end
    end

    local env = get_virtual_env(env_var)
    if env then
        newPrompt = addTextWithColor("", env.." "..plc_prompt_lambSymbol.." ", ansiFgClrYellow, ansiBgClrBlack)
        -- clink.prompt.value = string.gsub(clink.prompt.value, plc_prompt_lambSymbol, newPrompt)
        clink.prompt.value = clink.prompt.value..newPrompt

    end
end

local function get_conda_env()
	append_prompt("CONDA_DEFAULT_ENV")
end

local function get_venv_env()
	append_prompt("VIRTUAL_ENV")
end

clink.prompt.register_filter(get_venv_env, 101)
clink.prompt.register_filter(get_conda_env, 101)
