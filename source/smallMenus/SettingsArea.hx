package smallMenus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

import flixel.FlxCamera; // So I can have the options in a "contained" area.
import flixel.util.FlxColor; // For the reference box and text. //

class SettingsArea extends FlxSubState
{

var focusItemCamera:FlxCamera; // thank goodness i've used flxcameras in a project before since i dont wanna re-learn it

	public function new()
	{
		super();
	}

	override function create()
	{
		super.create();

		var deg:FlxText;
				deg = new FlxText((FlxG.width - 600), 270, 500); // x, y, width
				deg.text = "Settings?"; // Very convinient...
				deg.setFormat("FOT-RodinBokutohPro-B.otf", 25, 0xff403a46);
				deg.antialiasing = true;
				deg.updateHitbox();
				add(deg);

		    //focusItemCamera = new FlxCamera(FlxG.width / 4, FlxG.height / 4);
		focusItemCamera = new FlxCamera();
		focusItemCamera.bgColor = FlxColor.TRANSPARENT;
		add(focusItemCamera);
		FlxG.cameras.add(focusItemCamera, false);
		/* Notes:
		Area size: 1123 x 778
		Capsules are 1123x118 (dropshadow included)
		Capsule Y difference is 150. (0, 150, 300, etc.)
		Setting button position in relation: 777, 15
		Setting button: Fot Bold
		*/






	}


	override function update(elapsed:Float){

		super.update(elapsed);


	}

	private function closeSub():Void
	{
		close();
	}

}
