local spell, super = Class(Spell, "kromer")

function spell:init()
    super:init(self)

    -- Display name
    self.name = "BigDeal"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Drain\n enemy."
    -- Menu description
    self.description = "Steal KROMER from\nthe enemy."

    -- TP cost
    self.cost = 25

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = {"damage"}
end

function spell:getTPCost(chara)
    local cost = super:getTPCost(self, chara)
    if chara and chara:checkWeapon("thornring") then
        cost = Utils.round(cost / 2)
    end
    return cost
end

function spell:onStart(user, target)
    Game.battle:battleText(self:getCastMessage(user, target))
    user:setAnimation("battle/grow", function()
        local result = self:onCast(user, target)
        if result or result == nil then
            Game.battle:finishActionBy(user)
        end
    end)
end

function spell:onCast(user, target)
	--user:setAnimation("battle/grow")
	local spam = ParticleAbsorber(user.x,user.y-60,{
		amount = 2,
		layer = "below_bullets",
		every=1/10,
		time=-1,
		angle = {-math.pi/4, math.pi*0.25},
		dist = {25,75},
		scale={0.25,0.75},
		shrink = 0.01,
		move_time = 0.5,
	
	
	})
	kromers={}
	for i=1,#Game.battle.enemies do
		local vectorx=user.x-Game.battle.enemies[i].x
		local vectory=user.y-60-Game.battle.enemies[i].y
		local kromer = ParticleAbsorber(user.x,user.y-60,{
			amount = 1,
			layer = "below_bullets",
			texture = "kromer",
			auto=false,
			time=-1,
			rotation = 0,
			angle = -math.atan2(vectorx,vectory)-math.pi/2-math.pi/32,
			dist = math.sqrt(vectorx*vectorx+vectory*vectory),
			scale={1,2},
			shrink = 0.003,
			move_time = {1.25,1.75},
		})
		table.insert(kromers,kromer)
		Game.battle:addChild(kromer)
	end
	
	
	Game.battle:addChild(spam)
    Game.battle.timer:script(function(wait)
		wait(1/2)
        for i=0,user.chara:getStat("magic")-5 do
			local damage = (user.chara:getStat("magic")+user.chara:getStat("attack"))*math.ceil((user.chara:getStat("magic")+user.chara:getStat("attack"))/20)+math.random(-5,10)
			if(#Game.battle.enemies==0)then
				break
			end
			local target=math.random(1,#Game.battle.enemies)
			local removekromer=false
			if (Game.battle.enemies[target].health<=damage)then
				removekromer=true
			end
			Game.battle.enemies[target]:hurt(damage, user, Game.battle.enemies[target].onDefeatFatal)
			kromers[target]:emit()
			if(removekromer)then
				table.remove(kromers,target)
			end
			wait(1/3)
		end
		wait(15/15)
		spam:remove()
		wait(5/15)
		user.sprite.head.alpha=0
		user.sprite.jaw.alpha=0
		user:setAnimation("battle/shrink")
		wait(1/3)
        Game.battle:finishActionBy(user)
    end)

    return false
end

return spell