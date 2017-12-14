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
