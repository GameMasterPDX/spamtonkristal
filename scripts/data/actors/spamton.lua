local actor, super = Class(Actor, "spamton")

function actor:init()
    super:init(self)

    -- Display name (optional)
    self.name = "Spamton"
    -- Width and height for this actor, used to determine its center
    self.width = 34
    self.height = 36

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {7, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "party/spamton"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Table of sprite animations
    self.animations = {
        -- Movement animations
        ["slide"]               = {"slide", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 2/15, false},
        ["battle/spell"]        = {"battle/act", 1/15, false},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/grow", 1/15, false},
        ["battle/act_ready"]    = {"battle/actready", 0.3, true},
        ["battle/spell_ready"]  = {"battle/actready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/idle", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"battle/hurt", 0.2, false},
        ["battle/intro"]        = {"battle/idle", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
		
		["battle/grow"]        	= {"battle/grow", 1/15, false,next ="battle/big"},
		["battle/big"]        	= {"battle/big", 1/15, false},
		["battle/shrink"]       = {"battle/shrink", 1/15, false,next ="battle/shrink2"},
		["battle/shrink2"]       = {"battle/shrink", 1/15, false,next ="battle/idle"},

        -- Cutscene animations
        ["jump_fall"]           = {"fall", 1/5, true},
        ["jump_ball"]           = {"ball", 1/15, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},

        ["walk_blush/down"] = {0, 0},

        ["slide"] = {0, 0},

        -- Battle offsets
        ["battle/idle"] = {0, 0},

        ["battle/attack"] = {-17, -48},
        ["battle/attackready"] = {0, 0},
        ["battle/act"] = {0, -2.25},
        ["battle/actend"] = {0, -2.25},
        ["battle/actready"] = {0, -2.25},
        ["battle/item"] = {0, 0},
        ["battle/itemready"] = {0, 0},
        ["battle/defend"] = {-5, 0},

        ["battle/defeat"] = {0, 0},
        ["battle/hurt"] = {-9, -1},

        ["battle/intro"] = {0, 0},
        ["battle/victory"] = {0, 0},
		
	["battle/grow"] = {-17, -31},
	["battle/big"] = {-17, -31},
	["battle/shrink"] = {-17, -31},

        -- Cutscene offsets
        ["pose"] = {-4, -2},

        ["fall"] = {-5, -6},
        ["ball"] = {1, 8},
        ["landed"] = {-4, -2},

        ["fell"] = {-14, 1},

        ["sword_jump_down"] = {-19, -5},
        ["sword_jump_settle"] = {-27, 4},
        ["sword_jump_up"] = {-17, 2},

        ["hug_left"] = {-4, -1},
        ["hug_right"] = {-2, -1},

        ["peace"] = {0, 0},
        ["rude_gesture"] = {0, 0},

        ["reach"] = {-3, -1},

        ["sit"] = {-3, 0},

        ["t_pose"] = {-4, 0},
    }
end

function actor:onSpriteInit(sprite)
    sprite.draw_children_below = 0
	
	local head = Sprite("party/spamton/battle/head")
	head.origin_x=0.5
	head:play(1/6, true)
	head.origin_y=0.5
    sprite:addChild(head)
	sprite.head=head
	sprite.head.y=7
	sprite.head.x=8
	sprite.head.layer=1
	
	local jaw = Sprite("party/spamton/battle/jaw")
	jaw.origin_x=0.5
	jaw.origin_y=0.5
    sprite:addChild(jaw)
	sprite.jaw=jaw
	sprite.jaw.y=28
	sprite.jaw.x=15
	sprite.jaw.layer=1
	
	sprite.headsiner=90
	sprite.jawsiner=270
	
	
	sprite.siner=0
end

function actor:onSpriteUpdate(sprite)
	sprite.x=10*math.sin(math.rad(6*sprite.siner))
	if sprite.anim=="battle/idle" then
		--sprite.siner=sprite.siner+DTMULT
	else
		--sprite.siner=0
	end
	if sprite.anim=="battle/big" then
		sprite.headsiner=sprite.headsiner+DTMULT
		sprite.jawsiner=sprite.jawsiner+DTMULT
		sprite.head.y=2+5*math.sin(math.rad(50*sprite.headsiner))
		sprite.jaw.y=28-3*math.sin(math.rad(50*sprite.headsiner))
		sprite.jaw.alpha=1
		sprite.head.alpha=1
	else
		sprite.headsiner=90
		sprite.jawsiner=270
		sprite.jaw.alpha=0
		sprite.head.alpha=0
	end
	
	
end


return actor
