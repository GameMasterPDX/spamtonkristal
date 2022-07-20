return{

	id = "dumpster",

	-- Width and height of the actor (if unsure, just use sprite size)
    width = 58,
    height = 64,

    -- In-world hitbox, relative to the actor's topleft
    -- (these numbers are based on the actual deltarune hitbox)
    hitbox = {0, 0, 58, 64},

    -- Path to the actor's sprites
    path = "objects/dumpster",
    -- Default animation or sprite relative to the path
    default = "closed",

    animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["closed"] = {"closed", 0.25, true},
        ["open"] = {"open", 0.25, true},
        ["open_over"] = {"open_over", 0.25, true},
        ["open_empty"] = {"open_empty", 0.25, true},
    },

    offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["closed"] = {0, 0},
        ["open"] = {0, 0},
        ["open_over"] = {0, 0},
        ["open_empty"] = {0, 0},
    },

}