package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

import flixel.ui.FlxButton;
import flixel.util.FlxColor;

import sys.FileSystem;
import flixel.text.FlxText;
import Sys; //lowercase and uppercase Sys aer differetn!


class Start extends FlxState
{
	// Last modified: November 19th, 2025
	// sys.io.File.getContent('assets/data/v1Credits.txt')
	//var referenceFile = sys.io.File.getContent('assets/data/test_execute.json');
	var parsedFile = haxe.Json.parse(sys.io.File.getContent('assets/data/test_execute.json'));
	var commandA:String;
	var commandB:String;
	override public function create()
	{
		//parsedFile = haxe.Json.parse(referenceFile);

		var background = new FlxSprite();
		background.loadGraphic("assets/images/backgrounds/RiiSU_SettingsBackground.png");
		background.screenCenter();
		add(background);

		var text = new FlxText();
		text.text = "
		Title:" + parsedFile.name
		+ "\nDescription: " + parsedFile.description +
		"\nPath: " + parsedFile.path +
		"\nRank: " + Std.string(parsedFile.ranking) + " end." +
		"\n\nRaw JSON Data:" + sys.io.File.getContent('assets/data/test_execute.json');
		text.color = FlxColor.PURPLE;
		text.size = 24;
		text.x = 20;
		text.y = 20;
		//text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);
		add(text);

		super.create();


		var button = new FlxButton(0, 0, "Click me", onButtonClicked);
		button.screenCenter();
		add(button);

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function onButtonClicked()
	{

		commandA = parsedFile.path + parsedFile.file + ' "' + parsedFile.rom + '"'; // Reason the rom area is put in "" is since I have it saved in a folder with a space, and it seems to break that way.
		commandB = " ";
		FlxG.camera.flash(FlxColor.CYAN, 0.33);
		trace(commandA);
		Sys.command(commandA);

		FlxG.camera.flash(FlxColor.CYAN, 0.33);
		trace(commandB);
		Sys.command(commandB);
	}

}
