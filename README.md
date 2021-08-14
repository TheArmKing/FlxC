# FlxC
<b>Flex2MSConverter</b> for jailbroken iOS to help you convert your patches to MS easily and accurately!

# Installation
Download the deb from releases and simply install on your jailbroken iOS device. 

# Usage
<b>FlxC</b> (Shows Menu to select Patch)\
<b>FlxC [Patch Name]</b>

# Features
1) Finds classes, methods and hooks them accordingly
2) Assigns special names to each of the arguments automatically
3) Reads which argument is modified, and which is not
4) Returns a value or adds a %orig hook accordingly
5) Auto hooks multiple functions in the same class
6) Supports all the data types! --> `int`, `float`, `bool`, `long`, `double`, `id`, `NSNumber`, `NSString`, `UIColor`, `NSDate` ( if you know more Contact me )
7) Fast and Simple to Use! ( Also provides a Selector Menu to Choose from all the patches on your device )

# Note
1) The script is heavily dependant on `xmllint`, so install `xml2` from Cydia (it should be there by default from either Saurik's repo or Sam Bingner's)
2) After converting a Flex patch to MS, the script usually copies the output to the clipboard for witch `pbcopy` is required. If you don't have it then you can get it from https://github.com/TheArmKing/pbcopy-ios/releases
3) <b>If you encounter any bugs/errors, contact @TheArmKing on Discord - discord.gg/85jceTE </b>

# Changelog
v1.1
- Removed MacOS version
- Added a list of paths to search for the `patches.plist` file (Now supports Flex 3)
- Added root check to make sure the script has the privileges to move/copy files
- Added a check to see if `xmllint` is installed
- Added a warning to see if `pbcopy` is installed
- Changed output .xm numbering system from `(1).xm` to `_1.xm`
- Changed installation from a manual `FlxCInstaller.sh` bash file to automatic `.deb` installation
- Updated contact information

v1.0
- Initial Release
