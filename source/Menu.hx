package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

import flixel.text.FlxText;
import Sys; // For name detection.
import Date; // For the date
import DateTools;
import flixel.group.FlxGroup.FlxTypedGroup; // For menu buttons.

/* For submenus */
import smallMenus.*;
import flixel.FlxSubState;

/* For animations. */
import flixel.tweens.FlxTween; // this should be it.
import flixel.tweens.FlxEase;
// https://haxeflixel.com/demos/FlxTween/ Worth it.
import flixel.util.FlxTimer;

class Menu extends FlxState
{

var backgroundHome:FlxSprite;
var backgroundSetting:FlxSprite;
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
		lime.app.Application.current.window.opacity = 0;
		backgroundHome.alpha = 1;
		FlxTween.tween(lime.app.Application.current.window, {opacity: 1}, 0.5, {type: FlxTweenType.ONESHOT, ease: FlxEase.cubeOut});

		// Modified from https://discord.com/channels/162395145352904705/165234904815239168/950650164295651358 while trying to look for an example of tweening an integer which I thought I needed but realized I could've used this.
		/*#else
		FlxTween.tween(backgroundHome, {alpha: 1}, 0.5,{type: FlxTweenType.ONESHOT, ease: FlxEase.cubeOut});
		#end*/

		mainText = new FlxText(115, 54, 500); // x, y, width
		mainText.text = nameTitle;
		mainText.setFormat(defaultFont, 52, mainColor);
		mainText.antialiasing = true;
		mainText.updateHitbox();
		add(mainText);

		// Ensure that it can get to its required position.
		mainText.alpha = 0.01; // So it can be loaded, as I heard doing an alpha of 0 just deloads the sprite.
		mainText.x += 75;
		var timer:FlxTimer = new FlxTimer();
		timer.start(0.25,
		(_) -> {
		FlxTween.tween(mainText, {x: 115, alpha: 1}, 0.5,
			{type: FlxTweenType.ONESHOT, ease: FlxEase.cubeOut});
		}
		);

		statisticsText = new FlxText(1800, 67, 500); // x, y, width
		statisticsText.text = "____";
		statisticsText.setFormat(defaultFont, 24, mainColor, RIGHT);
		statisticsText.x = (1920 - 119 + 3) - statisticsText.width; // Should work with custom screen resolutions when the time comes for that.
		statisticsText.antialiasing = true;
		statisticsText.updateHitbox();
		add(statisticsText);

		var staTextNeed = statisticsText.x;
		statisticsText.x += 30;
		statisticsText.alpha = 0.01;

		var timer:FlxTimer = new FlxTimer();
		timer.start(1,
		(_) -> {	FlxTween.tween(statisticsText, {x:staTextNeed, alpha: 1}, 1,
			{type: FlxTweenType.ONESHOT, ease: FlxEase.cubeOut});}
		);

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
			backgroundHome = new FlxSprite();
			backgroundHome.loadGraphic("assets/images/backgrounds/Home_Light.png");
			backgroundHome.screenCenter();
			backgroundHome.alpha = 0.01;
			add(backgroundHome);

			backgroundSetting = new FlxSprite();
			backgroundSetting.loadGraphic("assets/images/backgrounds/Home_Light.png");
			backgroundSetting.screenCenter();
			backgroundSetting.alpha = 0.01;
			add(backgroundSetting);
	}

	override public function update(elapsed:Float){

		super.update(elapsed);
		appGetDate();

		if (menuTab > 0)
			mainText.text = menuEntries[menuTab];
		else
			mainText.text = nameTitle;



//					tsp.text = "Current Tab: " + menuEntries[menuTab] + ", Entry #" + menuTab + "\n Proper Entry: " + (menuTab + 1);
tsp.text = "Current Tab: " + menuTab + ", Intended Tab: " + menuEntries[menuTab] ;

		if (canSwitchTabs){ // The inputs can be accessed within the substates, so they can easily work.
				//trace("Before: " + menuTab);
				if (FlxG.keys.justPressed.Q)
				{
						//menuPrimaryButtons.members[menuTab].animation.play("idle");
						pageSwitch(-1, false);
				}
				if (FlxG.keys.justPressed.E)
				{
						//menuPrimaryButtons.members[menuTab + 1].animation.play("idle");
						pageSwitch(1, false);
				}
				//trace("After: " + menuTab);
		}

	}


	/*function pageSwitch(changeValue:Int){
				canSwitchTabs = false;
				trace(menuEntries[menuTab]);

				//if (changeValue == null){changeValue = 1;}
				//menuTab += changeValue;
				trace("Changed value by:" + changeValue + ". Value now: " + menuTab);

				//if (menuTab > -1 || menuTab < 4){
				if (menuTab > -1 && menuTab < 4){ // Checks if it's inbetween -1 & +4.
					menuPrimaryButtons.members[menuTab].animation.play("select");
					trace("true");


					menuTab += changeValue;
					trace("Changed value successfully!");
					var timer:FlxTimer = new FlxTimer();
							timer.start(0.1, // For a small delay.
							(_) -> {
								canSwitchTabs = true;

								}
							);

				}


				if (menuTab == 0){ // Will be replaced with a case switch soon.
							openSubState(new HomeMesu());
							//tsp.text = "Place: HomeMesu.hx (" + menuEntries[menuTab] + ")";
				}
				if (menuTab == 2){ // Will be replaced with a case switch soon.
							openSubState(new SettingsArea());
				}

	}*/
	function pageSwitch(changeValue:Int, funcReload:Bool = false){ // funcReload does not do anything other than serving as an identifier as to if the function reran itself.
	menuPrimaryButtons.members[menuTab].animation.play("idle");
	tsp.text = "Current Tab: " + menuTab + ", Intended Tab: " + menuEntries[menuTab] ;

	canSwitchTabs = false;
	//trace(menuEntries[menuTab]);
	menuTab += changeValue;
	trace("Changed value by: " + changeValue + ". New value: " + menuTab);

				if (menuTab > -1 && menuTab < 4){ // Checks if it's inbetween -1 & +4.
					menuPrimaryButtons.members[menuTab].animation.play("select");
					trace("true");
					canSwitchTabs = true;
				}else{
					if (menuTab < 0) // If the value is under zero, then it adds three. So -1 would become 3, which would be the final entry.
						menuTab += 4;
					if (menuTab > 3) // If the value is above three, then it rolls back four. So 4 would become 0, which would be the first menu entry.
						menuTab -= 4;

					pageSwitch(0, true);
				}

	}


	function appGetDate(){ // to whoever sees the first commit of this, say thank you to spile from the haxe discord
		var now = Date.now();
		var curDate = DateTools;
		var formattedTime:String;

			/* https://www.geeksforgeeks.org/python/python-strftime-function/ */
			formattedTime = (DateTools.format(now, "%A %m/%d -%l:%M %p"));
			//trace(formattedTime);
			statisticsText.text = formattedTime + // add system username here LOL
			#if debug
				"\nDebug Build" + // I'd make this a one-liner, but I'd get a weird error if I did.
			#end
			" ";

    }

    function padZero(s:String):String {
		return (s.length == 1) ? "0" + s : s;
	}

}
