#!/bin/sh
export PATH=$PATH$( find $HOME/.local/bin -type d -printf ":%p" )
export QT_QPA_PLATFORMTHEME=qt5ct

# Fix Netbeans white screen
export _JAVA_AWT_WM_NONREPARENTING=1

# Add cargo directory to path
export PATH="$HOME/.cargo/bin:$PATH"
