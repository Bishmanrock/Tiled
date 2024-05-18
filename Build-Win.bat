@echo off
setlocal

:: Define the output filename as a variable
set OUTPUT_FILE=Game

:: Define the error log file
set ERROR_LOG=Compiler.log

:: Clear the error log
echo. > "%ERROR_LOG%"
echo Error log started >> "%ERROR_LOG%"

:: Compile the program
echo Starting compile... >> "%ERROR_LOG%"

echo Filename set >> "%ERROR_LOG%"
echo Filename set

:: Define the subfolder where you want to build the executable
set BUILD_DIR=Builds\%OUTPUT_FILE%-Win
echo Export folder set >> "%ERROR_LOG%"
echo Export folder set

:: Create the subfolder and clear it if it exists
if not exist "%BUILD_DIR%" (
    mkdir "%BUILD_DIR%"
    echo Export folder doesn't exist. Created.
    echo Export folder doesn't exist. Created. >> "%ERROR_LOG%"
) else (
    del /q "%BUILD_DIR%\*.*"
    echo Cleared contents of export folder.
    echo Cleared contents of export folder. >> "%ERROR_LOG%"
)

:: Specify the paths to the libraries
set GLFW_LIBRARY=%CD%\includes\GLFW\glfw3.dll
set GLAD_SOURCE=%CD%\includes\glad\glad.c
set IMGUI_INCLUDE=%CD%\includes\imgui
set GLM_INCLUDE=%CD%\includes
set IMGUIFILEDIALOG_INCLUDE=%CD%\includes\ImGuiFileDialog

echo Included libraries. >> "%ERROR_LOG%"
echo Compiling... >> "%ERROR_LOG%"

:: Compile your C++ program with the corrected include path and the variable output filename
g++ -o "%BUILD_DIR%\%OUTPUT_FILE%.exe" *.cpp "%GLAD_SOURCE%" "%IMGUI_INCLUDE%\imgui.cpp" "%IMGUI_INCLUDE%\imgui_draw.cpp" "%IMGUI_INCLUDE%\imgui_widgets.cpp" "%IMGUI_INCLUDE%\imgui_tables.cpp" "%IMGUI_INCLUDE%\backends\imgui_impl_glfw.cpp" "%IMGUI_INCLUDE%\backends\imgui_impl_opengl3.cpp" "%IMGUIFILEDIALOG_INCLUDE%\ImGuiFileDialog.cpp" -IGLAD\include -IGLFW\include -I"%GLM_INCLUDE%" -I"%IMGUI_INCLUDE%" -I"%IMGUI_INCLUDE%\backends" -I"%IMGUIFILEDIALOG_INCLUDE%" -DGLFW_INCLUDE_NONE -L"%BUILD_DIR%" "%GLFW_LIBRARY%" -lopengl32 -lgdi32 >> "%ERROR_LOG%" 2>&1

:: Check if compilation was successful
IF %ERRORLEVEL% NEQ 0 (
    echo Compilation failed! Check %ERROR_LOG% for details. >> "%ERROR_LOG%"
    GOTO END
)

:: Only proceed if compilation was successful
echo Compilation successful! >> "%ERROR_LOG%"
echo Error Level: %errorlevel% >> "%ERROR_LOG%"

:: Copy required files
echo Copying additional resources...
copy textures.bin %BUILD_DIR% >> "%ERROR_LOG%" 2>&1
copy shaders.bin %BUILD_DIR% >> "%ERROR_LOG%" 2>&1
copy mesh.data %BUILD_DIR% >> "%ERROR_LOG%" 2>&1
copy brick.png %BUILD_DIR% >> "%ERROR_LOG%" 2>&1
echo Additional resources copied. >> "%ERROR_LOG%"

:: Run the compiled executable
echo Running the application...
start "" cmd /k "%BUILD_DIR%\%OUTPUT_FILE%.exe"

:END
echo Complete! >> "%ERROR_LOG%"
pause 