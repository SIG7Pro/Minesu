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
var columns:Int = 6;
var rows:Int = 4;

var iconSlot:FlxSprite;
var curMadeSelectionIcons:FlxTypedGroup<MenuIcon>; // These both have to be changed, whoops!

var homeLayout = haxe.Json.parse(sys.io.File.getContent('external/games/home_layout.json'));
var menuArrange:Array<String>;
var layout_xPosition_Before_Recount:Int = 0; // if position needed in the layout is larger than the amount of columns then it should wrap back to 0 by adding the column amount fo this variable and subtracting the position of an entry and this to get a position in the horizPositions' var and verticPositions too somehow
var layout_yPosition_Before_Recount:Int = 0; // I think I'll use this simialry or in conjunction with the other, but I don't know.

	public function new()
	{
		super();
	}

	override function create()
	{
		super.create();

		//menuArrange:new(string);
		menuArrange = homeLayout.arrangement;
		rows = horizPositions.length;
		columns = verticPositions.length;


		var deg:FlxText;
				deg = new FlxText((FlxG.width - 600), 156, 500); // x, y, width
				deg.text = "Layout:" + haxe.Json.stringify(menuArrange); // Very convinient...
				//deg.text = "Extra Placeholder";
				trace("Arrangement: " + haxe.Json.stringify(menuArrange));
				//trace("Note: " + homeLayout.note);
				deg.setFormat("FOT-RodinBokutohPro-B.otf", 25, 0xff403a46);
				deg.antialiasing = true;
				deg.updateHitbox();
				add(deg);

		curMadeSelectionIcons = new FlxTypedGroup<MenuIcon>();

		// user slameron suggested the idea of reading from an array and then moving based on division and stuff
					// so in theory i could turn the home_layout.json file into maybe some kinda global storage/options file too
					// as quoted from him or her:
						// if its all an array you could do insert on the array at the index you want it at and for the grid the x index would be the array position % columns and the y index would be Math.floor(array position / columns), i think

			makeBlankSpaces();

		//


		//var menuArrange.length;
				for (i in 0...menuArrange.length){

					//if (menuArrange)

					var testPoop:MenuIcon;
					var xPos:Int;
					var yPos:Int;

					xPos = horizPositions[ Std.int(rows - menuArrange.indexOf(menuArrange[i]) ) ];
					yPos = verticPositions[ Std.int(columns / menuArrange.indexOf(menuArrange[i]))       ];
					testPoop = new MenuIcon(
					//horizPositions[ Std.int( (menuArrange.indexOf(menuArrange[i], 0) / rows * 10))],
					//verticPositions[  Std.int( menuArrange.indexOf(menuArrange[i], 0)  / columns * 10)],
					xPos,
					yPos,
					menuArrange[i]);
					//trace(menuArrange[i] + ", x: " + Std.int(menuArrange.indexOf(menuArrange[i], 0) / rows * 10) + ", y: " + Std.int(menuArrange.indexOf(menuArrange[i], 0) / columns * 10) + ", Index: " + menuArrange.indexOf(menuArrange[i], 0));
					trace("Index: " + menuArrange.indexOf(menuArrange[i], 0) + ", X: " + xPos + ", Y: " + yPos);
				//add(testPoop);
					curMadeSelectionIcons.add(testPoop);

					// seems like duplicates just spawn in the same place as the OG ones? idk for sure
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

	function makeBlankSpaces(){
		for (h in 0...verticPositions.length){
				for (i in 0...horizPositions.length){
					iconSlot = new FlxSprite();
					iconSlot.loadGraphic("assets/images/menuBody/mainMenu/Blank Icon.png");
					iconSlot.x = horizPositions[i];
					iconSlot.y = verticPositions[h];
					iconSlot.updateHitbox();
					add(iconSlot);
				}
			}
	}
}
