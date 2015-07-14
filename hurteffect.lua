

PLUGIN.name = "More hurt effects"
PLUGIN.author = "Pokernut"
PLUGIN.desc = "Add more hurt effects."



local painSounds = {
	Sound("vo/npc/male01/pain01.wav"),
	Sound("vo/npc/male01/pain02.wav"),
	Sound("vo/npc/male01/pain03.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/male01/pain05.wav"),
	Sound("vo/npc/male01/pain06.wav")
}

local drownSounds = {
	Sound("player/pl_drown1.wav"),
	Sound("player/pl_drown2.wav"),
	Sound("player/pl_drown3.wav"),
}


if (SERVER) then

  function PLUGIN:PlayerHurt(client, attacker, health, damage)
	if ((client.nutNextPain or 0) < CurTime()) then
		local painSound = hook.Run("GetPlayerPainSound", client) or table.Random(painSounds)

		if (client:isFemale() and !painSound:find("female")) then
			painSound = painSound:gsub("male", "female")
		end
		client:EmitSound("physics/body/body_medium_impact_hard"..math.random(1, 6)..".wav", 80)

		client:EmitSound(painSound)
		client.nutNextPain = CurTime() + 0.33
		client:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
		client:ViewPunch(Angle(-1.3, 1.8, 0))
	end
  end

end
