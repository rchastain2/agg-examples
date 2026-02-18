-- =============================================================================
-- Pascal Expert
-- =============================================================================

local LPascalExpert = {}

local LComments, LLitterals, LDirectives = {}, {}, {} -- Tables

function LPascalExpert.AnalyzePascalText(AText)
--[[
  This is the main function. It
  - searches comments, litterals and directives;
  - copies them in tables;
  - replaces them with numerotated marks (as you can see in debug1.txt).
--]]
  local LText = AText
  
  local i, j, k = 1, 0, 0             -- Indexes
  local c, l, d = false, false, false -- Flags (comment, litteral, directive)
  local s = nil                       -- Character
  
  while i <= #LText do
    s = string.sub(LText, i, i)
    if c then
      if ((c == '{') and (s == '}'))
      or ((c == '(') and (s == ')') and (string.sub(LText, i - 1, i - 1) == '*'))
      or ((c == '/') and (string.sub(LText, i + 1, i + 1) == '\n')) then
        k = i
        table.insert(LComments, string.sub(LText, j, k))
        LText = string.sub(LText, 1, j - 1) .. '_comment_' .. #LComments .. '_' .. string.sub(LText, k + 1)
        c = false
        i = j - 1
      end
    else
      if l then
        if (s == "'") then
          l = l + 1
          if (l % 2 == 0) and (string.sub(LText, i + 1, i + 1) ~= "'") then
            k = i
            table.insert(LLitterals, string.sub(LText, j, k))
            LText = string.sub(LText, 1, j - 1) .. '_litteral_' .. #LLitterals .. '_' .. string.sub(LText, k + 1)
            l = false
            i = j - 1
          end
        end
      else
        if d then
          if (s == '}') then
            k = i
            table.insert(LDirectives, string.sub(LText, j, k))
            LText = string.sub(LText, 1, j - 1) .. '_directive_' .. #LDirectives .. '_' .. string.sub(LText, k + 1)
            d = false
            i = j - 1
          end        
        else
          if ((s == '{') and (string.sub(LText, i + 1, i + 1) ~= '$'))
          or ((s == '(') and (string.sub(LText, i + 1, i + 1) == '*'))
          or ((s == '/') and (string.sub(LText, i + 1, i + 1) == '/')) then
            j = i
            c = s
          else
            if (s == "'") then
              j = i
              l = 1
            else
              if ((s == '{') and (string.sub(LText, i + 1, i + 1) == '$')) then
                j = i
                d = true
              end
            end
          end
        end
      end
    end
    i = i + 1
  end
  return LText
end

function LPascalExpert.RestoreComments(AText)
  local LText = AText
  local i, j, k
  
  j, k = string.find(LText, '_comment_[%d]+_')
  while j do
    i = string.match(string.sub(LText, j, k), '[%d]+')
    i = tonumber(i)
    LText = string.sub(LText, 1, j - 1) .. LComments[i] .. string.sub(LText, k + 1)
    j, k = string.find(LText, '_comment_[%d]+_', j)
  end
  
  return LText
end

function LPascalExpert.RestoreLitterals(AText)
  local LText = AText
  local i, j, k
  
  j, k = string.find(LText, '_litteral_[%d]+_')
  while j do
    i = string.match(string.sub(LText, j, k), '[%d]+')
    i = tonumber(i)
    LText = string.sub(LText, 1, j - 1) .. LLitterals[i] .. string.sub(LText, k + 1)
    j, k = string.find(LText, '_litteral_[%d]+_', j)
  end
  
  return LText
end

function LPascalExpert.RestoreDirectives(AText)
  local LText = AText
  local i, j, k
  
  j, k = string.find(LText, '_directive_[%d]+_')
  while j do
    i = string.match(string.sub(LText, j, k), '[%d]+')
    i = tonumber(i)
    LText = string.sub(LText, 1, j - 1) .. LDirectives[i] .. string.sub(LText, k + 1)
    j, k = string.find(LText, '_directive_[%d]+_', j)
  end
  
  return LText
end

function LPascalExpert.CreateDebugFile(AFileName)
  if AFileName ~= nil then
    LFile = io.open(AFileName, 'w')
    for i = 1, #LComments   do LFile:write('COMMENT[' .. i .. ']=<<' .. LComments[i] .. '>>\n') end
    for i = 1, #LLitterals  do LFile:write('LITTERAL[' .. i .. ']=<<' .. LLitterals[i] .. '>>\n') end
    for i = 1, #LDirectives do LFile:write('DIRECTIVE[' .. i .. ']=<<' .. LDirectives[i] .. '>>\n') end
    LFile:close()
  end
end

return LPascalExpert
