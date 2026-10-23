@echo off
set TARGET=%1
if "%TARGET%"=="" set TARGET=main.tex

if not exist build mkdir build

echo [Opalith] Compiling %TARGET% (Pass 1/2)...
pdflatex -interaction=nonstopmode -file-line-error -output-directory=build %TARGET%
if errorlevel 1 goto error

echo [Opalith] Compiling %TARGET% (Pass 2/2 for TOC and references)...
pdflatex -interaction=nonstopmode -file-line-error -output-directory=build %TARGET%
if errorlevel 1 goto error

echo.
echo [Opalith] Compilation successful!
echo Output: build\%~n1.pdf
goto end

:error
echo.
echo [Opalith] Compilation failed. Check build\%~n1.log for details.
exit /b 1

:end
