package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

import flixel.ui.FlxButton;
import flixel.util.FlxColor;

import sys.FileSystem;
import flixel.text.FlxText;
import Sys; //lowercase and uppercase Sys aer differetn!

import Date;

import flixel.group.FlxGroup.FlxTypedGroup;

import smallMenus.*;
import flixel.FlxSubState;


class Menu extends FlxState
{

var backgroundA:FlxSprite;
var backgroundB:FlxSprite;
var backgroundDots:FlxSprite; // Wallpaper

// Text
var defaultFont:String = "FOT-RodinBokutohPro-B.otf";
var mainColor:Int = 0xff403a46;

// Text Elements
var mainText:FlxText;
var statisticsText:FlxText;

// Date and Time
var currentDate:String;
var properHour:Int;
var isPMTime:Bool;
var systemUsername:String = Sys.environment()["USERNAME"];

// Body
var menuBody:FlxSprite;

// Primary Buttons + Subset(?)
var nameTitle:String = "Home Mesu";

var menuSingleButton:FlxSprite; // Thanks https://www.thesaurus.com/browse/individual
var menuPrimaryButtons:FlxTypedGroup<FlxSprite>;

var menuEntries:Array<String> = ["Home", "Categories", "Settings", "Customize"];
var menuXPositions:Array<Int> = [103, 273, 443, 613];
//var animationFrames = [1, 2]; // https://snippets.haxeflixel.com/sprites/animation

var systemBar:FlxSprite;

	override public function create()
	{
		persistentUpdate = true;
 		persistentDraw = true;
		super.create();
		createWallpaper();

		mainText = new FlxText((122 - 6 - 1), (60 - 6), 500); // x, y, width
		mainText.text = nameTitle;
		mainText.setFormat(defaultFont, 52, mainColor);
		mainText.antialiasing = true;
		mainText.updateHitbox();
		add(mainText);

		statisticsText = new FlxText((1801), (70 + 3 - 6), 500); // x, y, width
		statisticsText.text = "____";
		statisticsText.setFormat(defaultFont, 24, mainColor, RIGHT);
		statisticsText.x = (1920 - 119 + 3) - statisticsText.width; // Should work with custom screen resolutions when the time comes for that.
		statisticsText.antialiasing = true;
		statisticsText.updateHitbox();
		add(statisticsText);

		menuPrimaryButtons = new FlxTypedGroup<FlxSprite>();
		add(menuPrimaryButtons);

		//menuXPositions = new Array<Int>();
		//add(menuXPositions);

		menuBody = new FlxSprite();
		menuBody.loadGraphic("assets/images/menuBody/mainMenu/Main Body.png");
		menuBody.x = 103;
		menuBody.y = 271;
		menuBody.color = 0xFFFFFFFF;
		add(menuBody);



		openSubState(new HomeMesu());



		systemBar = new FlxSprite();
		systemBar.loadGraphic("assets/images/bottomBar/bar.png");
		systemBar.y = FlxG.height - systemBar.height;
		add(systemBar);



		for (i in menuEntries){
			menuSingleButton = new FlxSprite();
			menuSingleButton.loadGraphic("assets/images/navButtons/" + i + ".png", true, 175, 125);
			menuSingleButton.y = 133;
			menuSingleButton.animation.add("idle", [0], 1);
			menuSingleButton.animation.add("select", [1], 1);
			menuPrimaryButtons.add(menuSingleButton);
		}

		for (i in 0...menuXPositions.length){

			for(i in 0...menuPrimaryButtons.members.length){
				menuPrimaryButtons.members[i].x = menuXPositions[i];
				//trace(menuXPositions[i]);
				menuPrimaryButtons.members[i].animation.play("idle"); //For testing.
			}

		}



	}

	function createWallpaper(){
		backgroundA = new FlxSprite();
			backgroundA.loadGraphic("assets/images/backgrounds/Home_Light.png"); // I'm thinking that maybe I could be able to change this for menus.
			backgroundA.screenCenter();
			//backgroundA.color = 0xFFe9ebff; // Tint, unused.
			add(backgroundA);
		/*backgroundB = new FlxSprite();
			backgroundB.loadGraphic("assets/images/backgrounds/Gradient.png");
			backgroundB.screenCenter();
			backgroundB.color = 0xFFc7cae5;
			add(backgroundB);
		backgroundDots = new FlxSprite();
			backgroundDots.loadGraphic("assets/images/backgrounds/Dots.png");
			backgroundDots.screenCenter();
			backgroundDots.blend = "screen";
			backgroundDots.alpha = 0.1;
			add(backgroundDots);*/
	}

	override public function update(elapsed:Float){
		super.update(elapsed);
		appGetDate();
	}

	function appGetDate(){ // to whoever sees the first commit of this, say thank you to spile from the haxe discord
		var now = Date.now();
		var hourTwelve:String;
		//trace(now.getDay());

		isPMTime = (now.getHours() > 12) ? true: false;
		if (isPMTime){
			hourTwelve = ("" + (now.getHours() - 12)); // Gets hour of the day and subtracts it by 12 for the proper time in the P.Ms.
		}else{
			hourTwelve = ("" + now.getHours());
		}

			currentDate = "" + (now.getMonth() + 1) + "/" + (now.getDate()) + " - " + // MM/DD
			hourTwelve  + ":" + padZero("" + now.getMinutes()) +  (if (isPMTime) " PM" else " AM") + // Hours + Minutes + AMPM
			/*#if debug
			"\nDebug build ran by " +
			#end
			"" + systemUsername*/
			#if debug
			"\nDebug Build" #end;

			statisticsText.text = currentDate;
			// Seconds for if I get to put an option to add seconds to the menu. /* + ":" padZero("" + now.getSeconds()) +*/
    }

    function padZero(s:String):String {
		return (s.length == 1) ? "0" + s : s;
	}

}
