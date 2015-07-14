PLUGIN.name = "Show FPS"
PLUGIN.author = "Made by L7D ported by Pokernut"
PLUGIN.desc = "Show FPS."

NUT_CVAR_FPS = CreateClientConVar("nut_fpsfuck", 1, true, true)


local langkey = "english"
do
	local langTable = {
		fpsEnable = "EnableShow FPS",
	}

	table.Merge(nut.lang.stored[langkey], langTable)
end

function PLUGIN:HUDPaint( )
	if ( GetConVarString( "nut_fpsfuck" ) == "0" ) then return end
	local curFPS = math.Round( 1 / FrameTime( ) )
	local minFPS = self.minFPS or 60
	local maxFPS = self.maxFPS or 100

	if ( !self.barH ) then
		self.barH = 1
	end
	
	self.barH = math.Approach( self.barH, ( curFPS / maxFPS ) * 100, 0.5 )
	
	local barH = self.barH 
	
	if ( curFPS > maxFPS ) then
		self.maxFPS = curFPS
	end
	
	if ( curFPS < minFPS ) then
		self.minFPS = curFPS
	end
	
	draw.SimpleText( curFPS .. " FPS", catherine_fps, ScrW( ) - 10, ScrH( ) / 2 + 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.RoundedBox( 0, ScrW( ) - 30, ( ScrH( ) / 2 ) - barH, 20, barH, Color( 255, 255, 255, 255 ) )
	draw.SimpleText( "Max : " .. maxFPS, catherine_fps, ScrW( ) - 10, ScrH( ) / 2 + 40, Color( 150, 255, 150, 255 ), TEXT_ALIGN_RIGHT, 1 )
	draw.SimpleText( "Min : " .. minFPS, catherine_fps, ScrW( ) - 10, ScrH( ) / 2 + 55, Color( 255, 150, 150, 255 ), TEXT_ALIGN_RIGHT, 1 )
end

if (CLIENT) then
	local catherine_fps = {
		font = "mailart rubberstamp",
		size = 27,
		weight = 500,
		antialias = true,
	}
end  


if (CLIENT) then


	function PLUGIN:SetupQuickMenu(menu)
		 local button = menu:addCheck(L"fpsEnable", function(panel, state)
		 	if (state) then
		 		RunConsoleCommand("nut_fpsfuck", "1")
		 	else
		 		RunConsoleCommand("nut_fpsfuck", "0")
		 	end
		 end, NUT_CVAR_FPS:GetBool())

		 menu:addSpacer()
	end

end