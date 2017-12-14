# termux-jdkTools
A bunch of jdk tools to use with Termux.Contains following tools:
1. java(just a classloader)

2. jar

3. javac

4. javah

5. javap and

6. javadoc. 
 
Just unzip the contents of JDK Tools.zip and place them in 
"~/../usr/bin/" or "$PREFIX/bin", both point at same directory. You can move the android.jar to sdcard or your preferred location and update the classpath options in scripts accordingly.

The maker_java is an example bash script for properly using the build tools. It has some variables left empty that are to be added by user to match their project structure.
The script assumes that project root directory has following structure :

1. $project_home_dir/bin        #to store resulting binary files
2. $project_home_dir/src        #where to  locate java source files

maker usage:
maker [ options ]

It takes following arguments: 

"-d"    : dx tool will dump verbose output

"-j"    : java compiler will dump verbose output

"-l"    : java2 launcher will dump verbose output

"-n"    : do Not set dx option "--no-strict"

"-s"    : dx tool will give standard "processing this-and-that" output

"-v"    : set verbose for all above i.e equivalent to "java2 -djl"

"-r"    : run the resulting program.

Java2 command requires following input syntax:

`java2 [options] -jar [path to jar] [fully qualified main class name]`
