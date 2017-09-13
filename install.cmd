@ECHO OFF
TITLE Install and Setup MCP
COLOR 0F
SETLOCAL ENABLEDELAYEDEXPANSION
CLS

:: 1.12 Version
SET MCP_LK=http://www.modcoderpack.com/files/mcp940.zip
SET MC_VEV=1.12

:: Downloading MCP
:: TODO Check if there is already and tmp folder
ECHO Downloading MCP...
DEL tmp /S /Q /F
MD tmp
CD tmp
powershell "(New-Object Net.WebClient).DownloadFile('%MCP_LK%', 'mcp.zip')"
ECHO.

:: Unzipping MCP
ECHO Unzipping MCP...
powershell "Expand-Archive mcp.zip -DestinationPath ."
DEL mcp.zip
ECHO.

:: Executing MCP
ECHO Executing MCP...
runtime\bin\python\python_mcp runtime\decompile.py %*
CD ..
ECHO.

:: Copy the sources from temp to main
ECHO Copying Sources...
ROBOCOPY tmp\src\minecraft\ minecraft\src\main\java /E
ECHO.

ECHO Rearrange..
MOVE minecraft\src\main\java\Start.java minecraft\src\main\java\net\minecraft\Start.java
ECHO.

ECHO Copying Libraries...
ROBOCOPY tmp\jars\libraries\ minecraft\lib\ /MIR
ECHO.

ECHO Copying workspace..
ROBOCOPY tmp\jars\ minecraft\workspace\ /MIR
ECHO.

:: Install Libraries
ECHO Installing Libraries
CD minecraft
CALL mvn install:install-file -Dfile=lib\com\mojang\authlib\1.5.25\authlib-1.5.25.jar -DgroupId=com.mojang -DartifactId=authlib ^
-Dversion=1.5.25 -Dpackaging=jar
ECHO.

CALL mvn install:install-file -Dfile=lib\com\mojang\patchy\1.1\patchy-1.1.jar -DgroupId=com.mojang ^
-DartifactId=patchy -Dversion=1.1 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\mojang\text2speech\1.10.3\text2speech-1.10.3.jar -DgroupId=com.mojang ^
-DartifactId=text2speech -Dversion=1.10.3 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\mojang\realms\1.10.17\realms-1.10.17.jar -DgroupId=com.mojang ^
-DartifactId=realms -Dversion=1.10.17 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\codecjorbis\20101023\codecjorbis-20101023.jar -DgroupId=com.paulscode ^
-DartifactId=codecjorbis -Dversion=20101023 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\codecwav\20101023\codecwav-20101023.jar -DgroupId=com.paulscode ^
-DartifactId=codecwav -Dversion=20101023 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\libraryjavasound\20101123\libraryjavasound-20101123.jar -DgroupId=com.paulscode ^
-DartifactId=libraryjavasound -Dversion=20101123 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\librarylwjglopenal\20100824\librarylwjglopenal-20100824.jar ^
-DgroupId=com.paulscode -DartifactId=librarylwjglopenal -Dversion=20100824 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\com\paulscode\soundsystem\20120107\soundsystem-20120107.jar -DgroupId=com.paulscode ^
-DartifactId=soundsystem -Dversion=20120107 -Dpackaging=jar

CALL mvn install:install-file -Dfile=lib\oshi-project\oshi-core\1.1\oshi-core-1.1.jar -DgroupId=oshi-project -DartifactId=oshi-core ^
-Dversion=1.1 -Dpackaging=jar

CALL mvn install:install-file -Dfile=workspace\versions\1.12\1.12.jar -DgroupId=net.minecraft -DartifactId=minecraft ^
-Dversion=1.12 -Dpackaging=jar

ECHO.

:: Clean Up
ECHO Clean Up..
RMDIR tmp /S /Q
ECHO.

ECHO Done.
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