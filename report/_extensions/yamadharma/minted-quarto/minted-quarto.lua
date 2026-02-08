-- Variable to store the include_listings flag
local include_listings = false
local options = {}
local level_option = ""
local inline_code = false

local function is_boolean(value)
	return type(value) == "boolean"
end

local function is_string(value)
	return type(value) == "string"
end

function set_minted_options(minted_options, l_option)
	-- quarto.log.output("options_in: " .. table.concat(minted_options, ",") .. " level_option: " .. tostring(l_option))
	if #minted_options == 0 then
		minted_options = ""
	else
		minted_options = table.concat(minted_options, ", ")
	end

	if #l_option > 0 then
		minted_options = l_option .. ", " .. minted_options
	end

	-- quarto.log.output("here are the options: " .. minted_options)
	if quarto.doc.is_format("latex") then
      quarto.doc.include_text('in-header', [[
	    \csundef{listoflistings}
	    ]]);
	end
	quarto.doc.use_latex_package("minted", minted_options)
	if quarto.doc.is_format("latex") then
      quarto.doc.include_text('in-header', [[
	    \usemintedstyle{emacs}
	    \setminted{mathescape=true}
	    \setminted{autogobble=true}
	    \setminted{breaklines=true}
	    \setminted{breakanywhere=true}
	    \setminted{frame=lines}
	    % \setminted{bgcolor=lightgray}
	    %\setminted{linenos=true,
	    %  numberblanklines=false,
	    %}  
	    ]]);
	end
end

-- Function to process metadata
function set_options(meta)
	-- quarto.log.output("Meta: " .. table.concat(meta.minted, ","))
	if meta.minted then
		-- Include listing environment wrapper
		if meta.minted.include_listings then
			include_listings = meta.minted.include_listings
			-- quarto.log.output("include listings da: " .. tostring(include_listings))
		end
		if meta.minted.level_option then
			level_option = meta.minted.level_option[1]["text"]
		else
			level_option = ""
		end
		if meta.minted.inline_code then
			inline_code = meta.minted.inline_code
		end
		-- Set minted options
		if meta.minted.options then
			for k, v in pairs(meta.minted.options) do
				table.insert(options, k .. "=" .. pandoc.utils.stringify(v))
			end
		end
	end
	-- quarto.log.output("options_in: " .. table.concat(options, ",") .. " level_option: " .. tostring(level_option))

	set_minted_options(options, level_option)
end

-- Function that processes CodeBlocks
function wrap_code(block)
	if #block.classes > 0 then
		local language = block.classes[1]
		-- quarto.log.output("include listings: " .. tostring(include_listings == true))
		if include_listings == true then
			local minted_env = "\\begin{listing}[H]\n\\begin{minted}{"
				.. language
				.. "}\n"
				.. block.text
				.. "\n\\end{minted}\n\\end{listing}"
			return pandoc.RawBlock("latex", minted_env)
		else
			local minted_env = "\\begin{minted}{" .. language .. "}\n" .. block.text .. "\n\\end{minted}"
			return pandoc.RawBlock("latex", minted_env)
		end
	else
		return block
	end
end

function wrap_inline_code(code)
	if inline_code == true then
		local language = nil
		if code.classes[1] == nil then
			language = "text"
		else
			language = code.classes[1]
		end
		local minted_env = "\\mintinline{" .. language .. "}{" .. code.text .. "}"
		return pandoc.RawInline("latex", minted_env)
	else
		return code
	end
end

return { { Meta = set_options }, { CodeBlock = wrap_code }, { Code = wrap_inline_code } }
