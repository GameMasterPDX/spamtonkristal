return {
	dumpster = function(cutscene)

		local spamton = cutscene:getCharacter("spamton")
		local facing = spamton.facing

        cutscene:setSpeaker(spamton)
		cutscene:text("* HOME SWEET [[HOA]]!")

		if facing == "up" then

        	cutscene:setSpeaker("") --reset speaker
			cutscene:text("(Give it a punch?)")

			choice = cutscene:choicer({"Yes", "No"})

			if choice == 1 then
        		spamton:setAnimation("punch")
            	Assets.playSound("locker")
        		spamton:shake(4)
        		cutscene:shakeCamera(4)
  				cutscene:wait(2)
			end
		end

		--spamton:setAnimation("laugh_glitch")

  		--cutscene:wait(4)
        spamton:resetSprite()

	end,

	start = function(cutscene, event)

		Game.world.music:stop() -- stops map music from playing in beginning
		--variables
		local spamton = cutscene:getCharacter("spamton")
		local maus = cutscene:spawnNPC("maus", 400, 280) --creates maus NPC
		local dumpster = cutscene:getCharacter("dumpster")
		local dump_ov = cutscene:spawnNPC("dumpster", dumpster.x, dumpster.y) --creates second sprite for dumpster

		local layer = spamton.layer --old layers for layer manipulation
		local layer2 = dumpster.layer

		--initialization
		spamton.noclip = true
		spamton:moveTo(680, 239) --move to initial position
	    spamton.visible = false --hides in dumpster (visible otherwise during shake)
	    spamton:setFacing("right")

		dumpster:setSprite("closed") --in map, default sprite is open, so switch to closed

		dump_ov.layer = layer + 2 --top
		spamton.layer = layer + 1 --middle
		dumpster.layer = layer --bottom (can't do layer-1, bc then it goes behind tiles)


		--choice = cutscene:choicer({"Skip", "No"}) --debug skipping
		choice = 2
		if choice == 2 then
			--move camera over to dumpster
			cutscene:panTo(660, 240, 3)
			cutscene:wait(cutscene:walkTo(maus, maus.x + 40, maus.y, 1)) --maus moves a bit
			cutscene:wait(0.5)
			cutscene:wait(cutscene:walkTo(maus, maus.x - 20, maus.y, 1)) --maus moves some more
			cutscene:wait(0.5)
			cutscene:wait(cutscene:walkTo(maus, maus.x + 90, maus.y, 2)) --maus again
			cutscene:wait(1)

			--open dumpster
			dumpster:setSprite("open") --i believe deltarune uses the empty open for the bottom sprite but it doesnt look exactly right
			dump_ov:setSprite("open_over")

			--maus alert. taken from chaser enemy
			Assets.playSound("snd_alert")
			local alert_icon = Sprite("effects/alert", maus.width/2)
			alert_icon:setOrigin(0.5, 1)
			alert_icon.layer = 100
			maus:addChild(alert_icon)

			--dumpster shake/sound noise
	        Assets.playSound("locker")
			dumpster:shake(4)
			dump_ov:shake(4)

			cutscene:walkTo(maus, -10, maus.y, 15) --maus runs away
			cutscene:wait(1)

			--slide spam up
	        spamton.visible = true
			cutscene:wait(cutscene:slideTo(spamton, spamton.x, spamton.y - 60, 1))

			--text
			Game.world.music:play("spamton_meeting_intro")
	        cutscene:setSpeaker(spamton)
			cutscene:text("* HEY      EVERY      !! IT'S\nME!!!")

			spamton:setScale(-2, 2) --flip so laugh sprite faces right
			spamton:setSprite("laugh")

			cutscene:text("* EV3RY  BUDDY  'S FAVORITE\n[[Number 1 Rated Salesman1997]]")

			spamton:setScale(2, 2) --flip back to normal
			spamton:setSprite("idle")

			cutscene:text("* SPAMT", nil, nil, {auto=true}) --args for auto advance

			spamton:setScale(-2, 2) --flip again
			spamton:setSprite("laugh")
			spamton:shake(4) --a lil shake <3

			cutscene:text("* SPAMTON G. SPAMTON!!")


			--loop laugh
			spamton:setAnimation("laughleft")

			--create new source for sound to allow for looping and not overriding music
			local laugh = Assets.newSound("spamton_laugh")
			laugh:setLooping(true)
			laugh:play()
			cutscene:wait(2.452) --lets it play at least 3 times i think
			laugh:stop()

			spamton:setScale(2, 2) --slip
			spamton:setSprite("idle")

			--fade out music
			Game.world.music:fade(0, 0.01) --makes this a slower fade?
			cutscene:wait(3.5)
			Game.world.music:stop() --need to stop stop music
			cutscene:wait(0.5)

			cutscene:text("* WELL IT'S [[Time is running\nout]] TO START THE DAY>!")
		end

	    spamton.visible = true --used in case debug skip
	    spamton:setFacing("left")
		spamton:jumpTo(560, 280, 20, 25, "jumpto", "idle") --jump!
		cutscene:wait(1)



		--Game:addPartyMember("miniton")
		--Game.world:spawnFollower("miniton")



		--get rid of temp NPCS
		dump_ov:remove() 
		maus:remove()

		--revert changes
	    spamton:resetSprite()
		spamton.noclip = false
		spamton.layer = layer
		dumpster.layer = layer2

		Game.world.music:play("spamton_meeting", 1) --play music and increase vol back to 1
	    event:setFlag("dont_load", true) --make sure this doesn't load again!
	end,

}