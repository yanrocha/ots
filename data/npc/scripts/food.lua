local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local voices = {
	{ text = 'Compre aqui sua food que salvara sua vida !' },
	{ text = 'Na falta de dedo, compre sua food aqui !' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Oi. Como posso te ajudar |PLAYERNAME|? Fale {trade} que lhe mostrarei minhas foods especiais.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sempre um prazer ajuda lo, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())