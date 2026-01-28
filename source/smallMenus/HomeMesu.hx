package smallMenus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import smallMenus.MenuIcon;

class HomeMesu extends FlxSubState
{

var horizPositions:Array<Int> = [141, 341, 541, 741, 941, 1141];
var verticPositions:Array<Int> = [302, 502, 702, 902];

var iconSlot:FlxSprite;
var curMadeSelectionIcons:FlxTypedGroup<MenuIcon>; // These both have to be changed, whoops!

var homeLayout = haxe.Json.parse(sys.io.File.getContent('external/games/home_layout.json'));
var menuArrange:Array<String>;

	public function new()
	{
		super();
	}

	override function create()
	{
		super.create();
		menuArrange = homeLayout.arrangement;

		//var placement:Array<String> = haxe.Json.parse(menuArrange);

		var deg:FlxText;
				deg = new FlxText((122), (156)); // x, y, width
				deg.text = "Layout:" + haxe.Json.stringify(menuArrange); // Very convinient...
				//deg.text = "Extra Placeholder";
				trace("Arrangement: " + haxe.Json.stringify(menuArrange));
				//trace("Note: " + homeLayout.note);
				deg.setFormat("FOT-RodinBokutohPro-B.otf", 52, 0xff403a46);
				deg.antialiasing = true;
				deg.updateHitbox();
				add(deg);

		curMadeSelectionIcons = new FlxTypedGroup<MenuIcon>();

		var newYPos:Int = 0;

		for (h in 0...verticPositions.length){
			for (i in 0...horizPositions.length){
				iconSlot = new FlxSprite();
				iconSlot.loadGraphic("assets/images/menuBody/mainMenu/Blank Icon.png");
				iconSlot.x = horizPositions[i];
				iconSlot.y = verticPositions[h];
				iconSlot.updateHitbox();
				add(iconSlot);

				var testPoop:MenuIcon;
				//testPoop = new MenuIcon(horizPositions[i], verticPositions[h], "exampleIcon1"); // vPos aligns with 0, 1, 2, and 3. // hPos aligns with the arrays.
				// user slameron suggested the idea of reading from an array and then moving based on division and stuff
					// so in theory i could turn the home_layout.json file into maybe some kinda global storage/options file too
					//newYPos
				if (menuArrange.indexOf(menuArrange[i], 0) > horizPositions.length){
					newYPos += 1; //maybe work into a new array<string?
					// thinking of something like if (index of entry) /  columns and floored could be for a good switch case, i dunno
				}
				testPoop = new MenuIcon(horizPositions[i], verticPositions[newYPos], menuArrange[i]);
				trace(menuArrange[i]);
				//add(testPoop);
				curMadeSelectionIcons.add(testPoop);
				//trace("Entry: " + horizPositions[i] + ", " + verticPositions[h] + ".");
			}
		}

		add (curMadeSelectionIcons);
	}

	override function update(elapsed:Float){

		super.update(elapsed);

		for (h in 0...curMadeSelectionIcons.members.length){
			if (FlxG.mouse.overlaps(curMadeSelectionIcons.members[h]))
				curMadeSelectionIcons.members[h].border.animation.play("select");
			else
				curMadeSelectionIcons.members[h].border.animation.play("idle");
		}

		for (i in 0...curMadeSelectionIcons.members.length){
			if (FlxG.mouse.overlaps(curMadeSelectionIcons.members[i]))
				curMadeSelectionIcons.members[i].border.animation.play("select");
			else
				curMadeSelectionIcons.members[i].border.animation.play("idle");
		}



	}

	private function closeSub():Void
	{
		close();
	}
}
