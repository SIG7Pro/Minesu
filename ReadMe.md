# Minesu
> A miniature scaled launcher for your PC! :ram:
 
![banner](https://repository-images.githubusercontent.com/1091421881/5d2a56b5-2b0d-42df-9bfb-6f7f1e195d1e "Minesu Banner")

(WIP description.)

## Disclaimer
- This is my first attempt at something like this. Please have patience!
- Due to this intending to be a "smaller" launcher app/frontend, **many features you would expect may not be included**.
- This is multi-platform for the major desktop operating systems!

## System Requirements
### Minimum Specs
- RAM: 8 MB
    - (This is heavily bound to change! Especially as this very bare-bones version of the app only runs with 4 MB on Hashlink ran with a 16GB RAM system!)
- CPU: Unknown
### Recommended Specs:
- RAM: 16 GB

## Compiling
Open your default command prompt and type in:

`lime test sys` (replacing sys with your platform of choice, which includes Hashlink.)

***This is to be done after all the requirements are met!*** Also unless old versions of Haxe are used, you cannot compile for macOS 10.12 or earlier.

#### Requirements:
- [Haxe](https://haxe.org)
- [HaxeFlixel](https://haxeflixel.com)
- hxdiscord_rpc (Optional)

As HaxeFlixel and both hxdiscord_rpc are both haxelibs, you can easily type:

`haxelib install haxeflixel` and `haxelib install hxdiscord_rpc` to install the libraries.
In addition, the average computer should be able to compile it.

##### System Specific
Windows requires a version of Microsoft Visual Studio to compile it. As far as I know, Visual Studio Community 2019 compiles it perfectly.

Linux has no specific requirements.

macOS may require "xcode-tools" (or whatever it's called) for compiling, but I do not know if they're required. Also requires macOS 10.13.6 (High Sierra) or later in order to compile, unless if you were to use an earlier version of Haxe, and in turn possibly earlier versions of the libraries required, but this is not supported and is prone to issues.

Hashlink compiles perfectly outside of the box, however it lacks Discord RPC by default.
- While the haxelib used is incompatible with Hashlink (only works on native, C++ targets, which HL isn't), it does get recognized by Discord if you've put it into the "Recognized Games" tab. Presumably best if done after testing a native build.

## To-Do's :poodle:
### High Priority
- [ ] Open app from configuration.
- [ ] Add proper settings
### Middle Priority
- [ ] ???
- [ ] Segmented Theming
        - (Themes with multiple segments that can be interchanged. Refer to Cocoon Launcher, Opera GX, or Vivaldi.)
- [ ] Controller Support
- [ ] Alphabet View of Games (Brief mind stuff, USB Loader GX)
### Low Priority
- [ ] Dark Mode
- [ ] ???
- [ ] Icon adjustments per platform and possibly per-theme.

## Features Excluded:
    - Scraping from titles (too complex for my skillset + tools used.)
    - Android Support (at this point just download iiSU, and also Android Studio gives me a headache and I uninstalled it to save on storage.)
        - Dual Screen Support (similar reason + illogical)
    - Networking (obvious)
    
    However if you'd like to commit any of these changes, then feel free! But they won't be maintained by me.

# Project Structure

## Assets

To be documented when project is more complete.

## Source Code

- Main.hx - The head of the project. Allows for minimal configuration to occur.
    - AssetPaths.hx - Stock code. Exact purpose is unknown, it could be alien!
    - import.hx - Used for importing certain HX files easily, clear purpose for those familiar with Haxe programming.
    
- Menu.hx - What holds all of the menus together.
