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

var tsp:FlxText; // Status text. Temporary.
var canSwitchTabs:Bool = true;
var menuTab:Int = 0; // 0 is the new 1, so when the variable is 4 then it should be 3, or wrap around to 0.
var changeValue:Int; // for one function just so i can reference it omg

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

		menuBody = new FlxSprite();
		menuBody.loadGraphic("assets/images/menuBody/mainMenu/Main Body.png");
		menuBody.x = 103;
		menuBody.y = 271;
		menuBody.color = 0xFFFFFFFF;
		add(menuBody);

				tsp = new FlxText((FlxG.width - 1000), 156, 500); // x, y, width
				tsp.text = "Place: None";
				tsp.setFormat("FOT-RodinBokutohPro-B.otf", 25, 0xff403a46);
				tsp.antialiasing = true;
				tsp.updateHitbox();
				add(tsp);

		//openSubState(new HomeMesu());



		systemBar = new FlxSprite();
		systemBar.loadGraphic("assets/images/bottomBar/bar.png");
		systemBar.y = FlxG.height - systemBar.height;
		//add(systemBar);



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
	}

	override public function update(elapsed:Float){

		super.update(elapsed);
		appGetDate();

		// For the status changing stuff. The text stuff is to be removed soon.
					if(menuTab == -1){menuTab = 3;}
					if(menuTab == 4) {menuTab = 0;}
					tsp.text = "Current Tab: " + menuEntries[menuTab] + ", Entry #" + menuTab + "\n Proper Entry: " + (menuTab + 1);


		if (canSwitchTabs){ // The inputs can be accessed within the substates, so they can easily work.
				if (FlxG.keys.justPressed.Q)
				{
						menuPrimaryButtons.members[menuTab].animation.play("idle");
						//menuTab -= 1;
						pageSwitch(-1);
				}
				if (FlxG.keys.justPressed.E)
				{
					//openSubState(new HomeMesu());
					menuPrimaryButtons.members[menuTab].animation.play("idle");
					//menuTab += 1;
					pageSwitch(1);
				}
		}


	}


	function pageSwitch(changeValue:Int){

				trace(menuEntries[menuTab]);

				/*if (changeValue < 0){ // For values in the negatives.
				menuTab +
				}else if (changeValue < 0){ // For values in the positives.

				}*/

				//if (changeValue == null){changeValue = 1;}
				menuTab += changeValue;

				//if
				if (menuTab > -1 || menuTab < 4){
					menuPrimaryButtons.members[menuTab].animation.play("select");
					trace("true");
				}


				if (menuTab == 0){ // Will be replaced with a case switch soon.
							openSubState(new HomeMesu());
							//tsp.text = "Place: HomeMesu.hx (" + menuEntries[menuTab] + ")";
				}
				if (menuTab == 2){ // Will be replaced with a case switch soon.
							openSubState(new SettingsArea());
				}

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
			#if debug "\nDebug Build"; // I'd make this a one-liner, but I'd get a weird error if I did.
			#end

			statisticsText.text = currentDate;
			// Seconds for if I get to put an option to add seconds to the menu. /* + ":" padZero("" + now.getSeconds()) +*/
    }

    function padZero(s:String):String {
		return (s.length == 1) ? "0" + s : s;
	}

}
