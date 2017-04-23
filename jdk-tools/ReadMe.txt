These are a bunch of JDK tools you can use with Termux for the time being. 
The original class files have been dexed with `dx` tool and repackaged into jar files.
just dump everything inside the zip into

~/../usr/bin/

and you should be fine. 
You may want to change the android.jar file's location to save little bit of space, just put it into somewhere in internal storage (/sdcard/YOUR_DESIRED_DIR) and symlink it to 

~/../usr/bin/

Not sure whether it'll work on those  Samsung's Marshmallow ROMS.
Just a temporary toolset to use until official Open JDK 9 is available on Termux.
            -Harshiv Patel.