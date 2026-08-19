package smallMenus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class SettingsArea extends FlxSubState
{

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







	}


	override function update(elapsed:Float){

		super.update(elapsed);


	}

	private function closeSub():Void
	{
		close();
	}

}
