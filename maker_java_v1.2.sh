#!/data/data/com.termux/files/usr/bin/bash
#which java compiler to use
compiler="ecj"

#java launcher to use
launcher="java2"

#name of final binary: put your desired name here without extension
app_name=""           #==========must not be empty

main_class=""		#========name of java class 
					#with main(String [] arg) method, 
					#must not be emty
#verbose flags
dexflag=false

#--no-strict : do not check for java package structure, 
#0=enable|otherwise disable
dx_nostrict=0

#run program after build
run_prog=1
project_home_dir='' #points to root dir of project
					#must not be empty

#jar libs: colon separated list of java libbraries
#make sure no spaces appear below.
jarlibs=""
#in case if project depends on a nativeLibrary add its path below:
#colon separated paths to shared libs
nativeLibPath=""

#arrays for program arguments and input files
dxargs=( )
compilerargs=( )
launcherargs=( )
sourcefiles=( )
classfiles=( )

#variable to store return values of commands
ret=

#check if ret is non-zero and bail
chkret ( ) {

	if [ $ret != 0 ]
	then
		echo -e "\n\terror occured at $1,abort!"
		exit 1
	fi
}

#this forces the output to be suppressed
#do SILENT=[non-zero value] to disable redirection
redirect_cmd( ) {
 
    if [ -n "$SILENT" ]; then
        "$@" > /dev/null
    else
        "$@"
    fi
}

#go to project_home_dir for processing
#in case if script is called from other dirs
if [ -d "$project_home_dir" ]
then
cd $project_home_dir
else
	echo -e "\n===================\tcould not read $project_home_dir \nplz set variables properly"
	exit 1
fi

#clean up previous binaries
rm -rf ./bin/*
mkdir ./bin/classes

#process command line args
if [ $# -ne 0 ]
then
	while getopts "djlnrsv" option
	do
		case $option in
			j) compilerargs+=( -verbose ) ;;
			d) dxargs+=( --verbose ) ;;
			n) dx_nostrict=1 ;;
			l) launcherargs+=( --verbose ) ;;
			s) SILENT=1 ;;

			v) 
				compilerargs+=( -verbose )
				dxargs+=( --verbose )
				launcherargs+=( --verbose ) ;;

			r) run_prog=0 ;;
		esac
	done
fi
#compile the sourcefiles

cd src

#set up java compiler arguments
compilerargs+=( -d ../bin/classes/ )
compilerargs+=( -warn:none )
#add any jarlib if exists
[[ ! -z $jarlibs ]] && \
compilerargs+=( -classpath "$jarlibs" )

sourcefiles+=( `find . -name '[A-Za-z0-9]*.java' -type f` )

$compiler "${compilerargs[@]}" "${sourcefiles[@]}"

ret=$?
chkret "$compiler : compile time error"

#calling dx : set up arguments
cd ../bin/classes/

#find any classfiles and dirs(expected to be java package stucture)
num_dirs=0
num_dirs=`ls -l|grep ^d|wc -l`

(( $num_dirs > 0 )) && \
	classfiles+=( 
	`find . -maxdepth 1 -type d|cut -d$'\n' -f 2-` ) ||
	classfiles+=( `find . -type f -name '*.class'` )
#set up dx arguments
	dxargs+=( --dex )
	dxargs+=( --output=../"$app_name.jar" )
	(( dx_nostrict == 0 )) && dxargs+=( --no-strict )

#dx requires space as delimeter
	[[ ! -z $jarlibs ]] && classfiles+=( ${jarlibs//:/ } )

#call it with redirect_cmd to suppress usual 
# "processing xyz class" output
redirect_cmd dx "${dxargs[@]}" "${classfiles[@]}"

# if run_prog is non-zero then exit
(( run_prog != 0 )) && exit

#go to project_home_dir -in case if called from other dirs
cd $project_home_dir
#set up launcherargs and call it.

[[ $launcher == "java2" && ! -z $nativeLibPath ]] && \
	launcherargs+=( -nlp=$nativeLibPath )

launcherargs+=( -jar ./bin/$app_name.jar )
launcherargs+=( $main_class )
$launcher "${launcherargs[@]}" this is -s 
