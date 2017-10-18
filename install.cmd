@ECHO OFF
TITLE Install and Setup MCP
COLOR 0F
SETLOCAL ENABLEDELAYEDEXPANSION
CLS

:: 1.8 Version
SET MCP_LK=http://www.modcoderpack.com/files/mcp918.zip
SET MC_VEV=1.8

:: Downloading MCP
:: TODO Check if there is already and tmp folder
ECHO == Downloading MCP ==
DEL tmp /S /Q /F
MD tmp
CD tmp
powershell "(New-Object Net.WebClient).DownloadFile('%MCP_LK%', 'mcp.zip')"
ECHO.

:: Unzipping MCP
ECHO == Unzipping MCP ==
powershell "Expand-Archive mcp.zip -DestinationPath ."
DEL mcp.zip
ECHO.

:: Executing MCP
:mcp
ECHO == Executing MCP ==
runtime\bin\python\python_mcp runtime\decompile.py %*
CD ..
ECHO.
PAUSE

:Ask
ECHO Did you get an error with twitch libraries?(Y/N)
set INPUT=
set /P INPUT=Type input: %=%
If /I "%INPUT%"=="y" goto yes
If /I "%INPUT%"=="n" goto no
echo Incorrect input & goto Ask
:yes
ECHO Please rename your twitch libraries from 32 to 64
ECHO.
ECHO "twitch-platform-6.5-natives-windows-32.jar" to "twitch-platform-6.5-natives-windows-64"
ECHO "twitch-external-platform-4.5-natives-windows-32.jar" to "twitch-external-platform-4.5-natives-windows-64.jar"
ECHO.
ECHO These files can be found in at .minecraft/libraries/tv/twitch/
ECHO Please re-run the installer.
PAUSE
EXIT
:no

:: Copy the sources from temp to main
ECHO == Copying Sources ==
ROBOCOPY tmp\src\minecraft\ minecraft\src\main\java /E
ECHO.

ECHO == Formatting Code ==
MOVE minecraft\src\main\java\Start.java minecraft\src\main\java\net\minecraft\Start.java
ECHO.

ECHO == Copying Libraries ==
ROBOCOPY tmp\jars\libraries\ minecraft\lib\ /MIR
ECHO.

ECHO == Copying workspace ==
ROBOCOPY tmp\jars\ minecraft\workspace\ /MIR
ECHO.

:: Install Libraries
ECHO == Installing Libraries ==
CD minecraft
CALL mvn install:install-file -Dfile=lib\com\mojang\authlib\1.5.21\authlib-1.5.21.jar -DgroupId=com.mojang -DartifactId=authlib  -Dversion=1.5.21 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\mojang\realms\1.7.39\realms-1.7.39.jar -DgroupId=com.mojang -DartifactId=realms -Dversion=1.7.39 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\tv\twitch\twitch\6.5\twitch-6.5.jar -DgroupId=tv.twitch.twitch -DartifactId=twitch  -Dversion=6.5 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\tv\twitch\twitch-external-platform\4.5\twitch-external-platform-4.5-natives-windows-64.jar -DgroupId=tv.twitch.twitch -DartifactId=twitch-external-platform  -Dversion=4.5-natives-windows-64 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\tv\twitch\twitch-platform\6.5\twitch-platform-6.5-natives-windows-64.jar -DgroupId=tv.twitch.twitch -DartifactId=twitch-platform  -Dversion=6.5-natives-windows-64 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\codecjorbis\20101023\codecjorbis-20101023.jar -DgroupId=com.paulscode -DartifactId=codecjorbis -Dversion=20101023 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\codecwav\20101023\codecwav-20101023.jar -DgroupId=com.paulscode -DartifactId=codecwav -Dversion=20101023 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\libraryjavasound\20101123\libraryjavasound-20101123.jar -DgroupId=com.paulscode -DartifactId=libraryjavasound -Dversion=20101123 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\librarylwjglopenal\20100824\librarylwjglopenal-20100824.jar -DgroupId=com.paulscode -DartifactId=librarylwjglopenal -Dversion=20100824 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\soundsystem\20120107\soundsystem-20120107.jar -DgroupId=com.paulscode -DartifactId=soundsystem -Dversion=20120107 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\oshi-project\oshi-core\1.1\oshi-core-1.1.jar -DgroupId=oshi-project -DartifactId=oshi-core -Dversion=1.1 -Dpackaging=jar

CALL mvn install:install-file -Dfile=workspace\versions\1.8.8\1.8.8.jar -DgroupId=net.minecraft -DartifactId=minecraft -Dversion=1.8.8 -Dpackaging=jar

ECHO.

:: Clean Up
ECHO == Clean Up ==
RMDIR tmp /S /Q
ECHO.

ECHO == Finished installing ==
ECHO.

PAUSE

:: 1.11 Version
::SET MCP_LK=http://www.modcoderpack.com/files/mcp937.zip
::SET MC_VEV=1.11.2

:: 1.10 Version
::SET MCP_LK=http://www.modcoderpack.com/files/mcp931.zip
::SET MC_VEV=1.10

:: 1.9 Version
::SET MCP_LK=http://www.modcoderpack.com/files/mcp928.zip
::SET MC_VEV=1.9.4

:: 1.8 Version
::SET MCP_LK=http://www.modcoderpack.com/files/mcp918.zip
::SET MC_VEV=1.8

:: May do a 1.7.10 at some point