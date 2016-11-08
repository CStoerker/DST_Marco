PrefabFiles = {
	"marco",
	"marco_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/marco.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/marco.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/marco.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/marco.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/marco_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/marco_silho.xml" ),

    Asset( "IMAGE", "bigportraits/marco.tex" ),
    Asset( "ATLAS", "bigportraits/marco.xml" ),
	
	Asset( "IMAGE", "images/map_icons/marco.tex" ),
	Asset( "ATLAS", "images/map_icons/marco.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_marco.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_marco.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_marco.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_marco.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_marco.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_marco.xml" ),
	
	Asset( "IMAGE", "images/names_marco.tex" ),
    Asset( "ATLAS", "images/names_marco.xml" ),
	
    Asset( "IMAGE", "bigportraits/marco_none.tex" ),
    Asset( "ATLAS", "bigportraits/marco_none.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.marco = "The Phoenix"
STRINGS.CHARACTER_NAMES.marco = "Marco"
STRINGS.CHARACTER_DESCRIPTIONS.marco = "*Turns into an egg upon death\n*His flames heal him\n*Can turn into a Phoenix"
STRINGS.CHARACTER_QUOTES.marco = "\"From the flames\""

-- Custom speech strings
STRINGS.CHARACTERS.MARCO = require "speech_marco"

-- The character's name as appears in-game 
STRINGS.NAMES.MARCO = "Marco"

AddMinimapAtlas("images/map_icons/marco.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("marco", "MALE")

