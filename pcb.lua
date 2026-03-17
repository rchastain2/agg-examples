-- =============================================================================
-- Pascal Code Beautifier
-- =============================================================================

-- =============================================================================

function FileExists(file)
  local f = io.open(file, 'rb')
  if f then f:close() end
  return f ~= nil
end

function LinesFrom(file)
  if not FileExists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    --lines[#lines + 1] = line
    lines[#lines + 1] = string.gsub(line, '%s+', '')
  end
  return lines
end

function ReadText(AFileName)
  local LFile, LErr = io.open(AFileName, 'r')
  if LFile then
    local LText = LFile:read('*a')
    io.close(LFile)
    return LText
  else
    io.write('[ERR] ' .. LErr)
    return nil
  end
end

function WriteText(AFileName, AText)
  local LFile, LErr = io.open(AFileName, 'w')
  if LFile then
    LFile:write(AText)
    io.close(LFile)
  else
    io.write('[ERR] ' .. LErr)
  end
end

-- =============================================================================

function NoCase(s)
  s = string.gsub(
    s,
    '%a',
    function(c) return string.format('[%s%s]', string.lower(c), string.upper(c)) end
  )
  return s
end

function Beautify(AText, AKeywords)
  local LText = AText
  for j = 1, #AKeywords do
    LText = string.gsub(LText, '%f[%a]' .. NoCase(AKeywords[j]) .. '%f[%A]', AKeywords[j])
    -- https://stackoverflow.com/a/32854326/18595765
  end
  return LText
end

-- =============================================================================

-- Main program

local LExpert = require('pexp') -- Pascal Expert
local LAppName = 'Pascal Code Beautifier 0.1'
local LUsage =
  'Usage:\n' ..
  '  lua pcb.lua IN_FILE [OUT_FILE]\n'
io.write(LAppName .. '\n')

if #arg >= 2 then
  local LKeywordsFile = arg[1]
  local LFileName     = arg[2]
  local LDestName     = (#arg >= 3) and arg[3] or LFileName
  
  -- Load keywords
  
  local LKeywords = LinesFrom(LKeywordsFile)
  io.write('[INFO] ' .. #LKeywords .. ' words loaded\n')

  -- Read file
  
  local LText = ReadText(LFileName)
  
  -- Remove comment, litterals and directives
  
  LText = LExpert.AnalyzePascalText(LText)
  
  -- Replace keywords
  
  LText = Beautify(LText, LKeywords)
  
  -- Restore comment, litterals and directives
  LText = LExpert.RestoreComments(LText)
  LText = LExpert.RestoreLitterals(LText)
  LText = LExpert.RestoreDirectives(LText)
  
  WriteText(LDestName, LText)
else
  io.write(LUsage)
end
