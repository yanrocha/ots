local aol = TalkAction("!aol")
local price_aol = 10000

function aol.onSay(player, words, param)

    if player:removeMoneyNpc(price_aol) then
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
        player:addItem(2173, 1)    
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("You don't have enought money.")
    end

      return true
end
aol:register()