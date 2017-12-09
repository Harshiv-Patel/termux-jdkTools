# termux-jdkTools
A bunch of jdk tools to use with Termux.Contains following tools:
1. java(just a classloader)

2. jar

3. javac

4. javah

5. javap and

6. javadoc. 
<H2>Installation: </H2>
Just unzip the contents of JDK Tools.zip and place them in 
~/../usr/bin/ and it should be done. You can move the android.jar to sdcard
and update the classpath options accordingly.

"java" is wrapper for dalvikvm which takes care of loading classes, So we are using Android Runtime to
run the code. 
