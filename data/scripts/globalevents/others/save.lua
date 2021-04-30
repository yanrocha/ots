local saving = GlobalEvent("saving")


function saving.onThink(interval, lastExecution)
	
	Game.broadcastMessage("Server is saving game in a few seconds. Please consider a little freeze...", MESSAGE_STATUS_WARNING)
	saveServer()
	SaveHirelings()
	return true
end

saving:interval(900000)
saving:register()