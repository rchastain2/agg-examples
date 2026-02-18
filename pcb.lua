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

function Beautify(AText, AKeyWords)
  local LText = AText
  for j = 1, #AKeyWords do
    LText = string.gsub(LText, '%f[%a]' .. NoCase(AKeyWords[j]) .. '%f[%A]', AKeyWords[j])
    -- https://stackoverflow.com/a/32854326/18595765
  end
  return LText
end

-- Main program

local LAppName = 'Pascal Code Beautifier 0.1'
local LUsage =
  'Usage:\n' ..
  '  lua pcb.lua IN_FILE [OUT_FILE]\n'

io.write(LAppName .. '\n')

local LExpert = require('pascal_expert')

local LKeyWords = LinesFrom('keywords.txt')

io.write('[INFO] ' .. #LKeyWords .. ' words loaded\n')

if #arg >= 1 then
  local LFileName = arg[1]
  local LDestName = (#arg >= 2) and arg[2] or LFileName
  
  -- Read file
  
  local LText = ReadText(LFileName)
  
  -- Remove comment, litterals and directives
  
  LText = LExpert.AnalyzePascalText(LText)
  
  -- Replace keywords
  
  LText = Beautify(LText, LKeyWords)
  
  -- Restore comment, litterals and directives
  LText = LExpert.RestoreComments(LText)
  LText = LExpert.RestoreLitterals(LText)
  LText = LExpert.RestoreDirectives(LText)
  
  WriteText(LDestName, LText)
else
  io.write(LUsage)
end
