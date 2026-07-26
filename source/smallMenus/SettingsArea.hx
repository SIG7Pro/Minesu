package smallMenus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
//import flixel.group.FlxGroup.FlxTypedGroup;
//import flixel.group.FlxSpriteGroup;
//import smallMenus.MenuIcon;

import haxe.ui.HaxeUIApp;
import haxe.ui.ComponentBuilder;
//import haxe.uitl.Logger; // ? //

//
import haxe.ui.components.Button;
import haxe.ui.containers.VBox;
import haxe.ui.core.Screen;


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

		/*var app = new HaxeUIApp();
		app.ready(
			function() {
				var main = ComponentBuilder.fromFile("assets/data/test.xml"); // whatever your XML layout path is
				app.addComponent(main);
				app.start();
			}
		);*/

		var main = new VBox();

		var button1 = new Button();
		button1.text = "Button 1";
		main.addComponent(button1);

		var button2 = new Button();
		button2.text = "Button 2";
		main.addComponent(button2);

		Screen.instance.addComponent(main);






	}

	override function update(elapsed:Float){

		super.update(elapsed);


	}

	private function closeSub():Void
	{
		close();
	}

}
