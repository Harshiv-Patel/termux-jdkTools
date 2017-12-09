These are a bunch of JDK tools you can use with Termux for the time being. 
The original class files have been dexed with `dx` tool and repackaged into jar files.
just dump everything inside the zip into

~/../usr/bin/

and you should be fine. 
You may want to change the android.jar file's location to save little bit of space, 
just put it into somewhere in internal storage (/sdcard/YOUR_DESIRED_DIR) and symlink it to 

~/../usr/bin/

Building java programs is done in following cycle: 
1. Compile java source files to create java bytecode i.e. ".class" files:
            as there is Eclipse Java Compiler available from Termux-Packages,
            you can use it to generate bytecode.
2. Convert class files to dalvik executable files i.e. ".dex" files with dx tool
3. Run dex files with 'java' command
The java command takes care of loading classes. It's a wrapper for the 
"dalvikvm" command so you are using Android Runtime to run you code hence limitations of Android applies
Not sure whether it'll work on those  Samsung's Marshmallow ROMS.
Just a temporary toolset to use until official Open JDK 9 is available on Termux.
            -Harshiv Patel.
