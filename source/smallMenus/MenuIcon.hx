package smallMenus;

import flixel.FlxG;
import flixel.FlxSprite;
//import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
//import flash.display.BitmapData;
import flixel.util.FlxSpriteUtil;

class MenuIcon extends FlxSpriteGroup{
// Reference A: https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/ui/freeplay/SongMenuItem.hx
	// Heavy reference as I've not worked with FlxSpriteGroups before and I just didn't want to get any example code up.
// Reference B: https://coinflipstudios.com/devblog/?p=421
	// Clipping code. Google AI (top of searches) seemed to basically regurgitate it lol. Note: I didn't use what Google regurgitated, I went straight to the source.
public var border:FlxSprite;
public var iconMask:FlxSprite;
public var iconToBeClipped:FlxSprite;
public var icon:FlxSprite;

var iconGraphic:String;
var selected:Bool;
var gameConfig = haxe.Json.parse(sys.io.File.getContent('assets/data/testGameConfig.json'));

    public function new(x:Int, y:Int, iconGraphic:String){ // iconGraphic will just be JSON loading, lol.
			super(x, y);

			border = new FlxSprite();
						border.loadGraphic("assets/images/menuBody/mainMenu/Icon Borders.png", true, 170, 170);
						border.animation.add("idle", [0], 1);
						border.animation.add("select", [1], 1);
						border.updateHitbox();
						border.alpha = 0.01;
							add(border);

			if (iconGraphic != null){
						gameConfig = haxe.Json.parse(sys.io.File.getContent('external/games/config/' + iconGraphic + '.json'));

						border.alpha = 1;

						iconMask = new FlxSprite();
						iconMask.loadGraphic("assets/images/menuBody/mainMenu/Icon Filling.png");
						iconMask.y = y;
						iconMask.x = x;
						iconMask.updateHitbox();

						iconToBeClipped = new FlxSprite();
						iconToBeClipped.loadGraphic("assets/images/menuBody/mainMenu/default.png"); // Default.

						if (gameConfig.icon != null)
							iconToBeClipped.loadGraphic("external/games/icons/" + gameConfig.icon + ".png");
						else
							iconToBeClipped.loadGraphic("external/games/icons/" + iconGraphic + ".png");

						iconToBeClipped.updateHitbox();
						iconToBeClipped.y = y;
						iconToBeClipped.x = x;


			icon = new FlxSprite();
			FlxSpriteUtil.alphaMaskFlxSprite(iconToBeClipped, iconMask, icon); // Seems the image I wanted to mask needed to go before what needed to be masked. Maybe it was in an update? I do not know.
			icon.updateHitbox();
				add(icon);

			}else{
				trace("Expected: " + iconGraphic + "at XY:" + x + "," + y);
			}

    }

}
