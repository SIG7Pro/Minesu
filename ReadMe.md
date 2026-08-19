# Minesu
> A miniature scaled launcher for your PC! :ram:
 
![banner](https://repository-images.githubusercontent.com/1091421881/5d2a56b5-2b0d-42df-9bfb-6f7f1e195d1e "Minesu Banner")

(WIP description.)

## Disclaimer
This is my first attempt at this type of launcher software stuff. It isn't meant to be full-featured, so some features may not be included. In addition, this is primarily focused for desktop, so an Android version *will not* be made.

## System Requirements
### Minimum Specs
- RAM: 8 MB
    - (This is heavily bound to change! Especially as this very bare-bones version of the app only runs with 4 MB on Hashlink ran with a 16GB RAM system!)
- CPU: Unknown
### Recommended Specs:
- RAM: 16 GB
### Tested
Tested on:
- Windows 11 w/ 16 GB RAM: Working, primary dev machine, virtualized in Hashlink and natively.
- Windows 7 with 4GB RAM: Working, outdated build, virtualized.

## Building the Software
#### Requirements:
- [Haxe](https://haxe.org/download/)
- [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)
- [hxdiscord_rpc](https://lib.haxe.org/p/hxdiscord_rpc/) (Optional)

As HaxeFlixel and both hxdiscord_rpc are both haxelibs, you can easily type:

`haxelib install haxeflixel` and `haxelib install hxdiscord_rpc` to install the libraries.
In addition, the average computer should be able to compile it.


### Compiling
Open your default command prompt and type in:

`lime test sys` (replacing sys with your platform of choice, which includes Hashlink.)

***This is to be done after all the requirements are met!*** 


##### System Specific
Windows requires a version of Microsoft Visual Studio to compile HaxeFlixel software easily as far as I know. Visual Studio Community 2019 yields the best results. I may consider seeing if there's a way to get other compilers working.

Linux has no specific requirements.

macOS may require "xcode-tools" (or whatever it's called) for compiling, but I do not know if they're required. Also unless old versions of Haxe are used, you cannot compile for macOS 10.12 or earlier.

Hashlink compiles perfectly outside of the box, however it lacks Discord RPC by default.
- While the haxelib used is incompatible with Hashlink (only works on native, C++ targets, which HL isn't), it does get recognized by Discord if you've put it into the "Recognized Games" tab. Presumably best if done after testing a native build.

## To-Do's :poodle:
### High Priority
- [ ] Open app from configuration.
- [ ] Add proper settings
### Middle Priority
- [ ] Segmented Theming
        - (Themes with multiple segments that can be interchanged. Refer to Cocoon Launcher, Opera GX, or Vivaldi.)
- [ ] Controller Support
- [ ] Alphabet View of Games (Brief mind stuff, USB Loader GX)
### Low Priority
- [ ] Dark Mode
- [ ] Icon adjustments per platform and possibly per-theme.

## Features Excluded:
    - Scraping from titles (too complex for my skillset + tools used.)
    - Android Support (at this point just download iiSU, and also Android Studio gives me a headache and I uninstalled it to save on storage.)
        - Dual Screen Support (similar reason + illogical)
    - Networking (obvious)
    
    However if you'd like to commit any of these changes, then feel free! But they won't be maintained by me.

# Project Structure

## Assets

To be documented when project is more complete. Especially for when themes are made and supported.

## Source Code

- Main.hx - The head of the project. Allows for minimal configuration to occur.
    - AssetPaths.hx - Stock code. Exact purpose is unknown, it could be alien!
    - import.hx - Used for importing certain HX files easily, clear purpose for those familiar with Haxe programming.
    
- Menu.hx - What holds all of the menus together.
