#!/bin/bash
 
#########################################################################
# Author: Zhaoting Weng
# Created Time: Mon 02 Jan 2017 01:49:57 PM CST
# Description: Setup tmux session/window environment for developing "demo"
#              using flask.
#########################################################################

TMUX_SESSION_NAME=flask_demo

ROOT_DIR=$HOME/github/code/LoginSystem/02_Demo
APP_DIR=$ROOT_DIR/app
MAIN_BP_DIR=$APP_DIR/main
AUTH_BP_DIR=$APP_DIR/auth
TEMPLATE_DIR=$APP_DIR/templates

# Start a tmux session(and a server) and open 1st window
tmux new-session -s $TMUX_SESSION_NAME -c $ROOT_DIR -n root -d

# New other windowns
tmux new-window -t $TMUX_SESSION_NAME:2 -c $APP_DIR -n app
tmux new-window -t $TMUX_SESSION_NAME:3 -c $MAIN_BP_DIR -n main
tmux new-window -t $TMUX_SESSION_NAME:4 -c $AUTH_BP_DIR -n auth
tmux new-window -t $TMUX_SESSION_NAME:5 -c $TEMPLATE_DIR -n templ

# Attach to session
tmux select-window -t $TMUX_SESSION_NAME:1
tmux attach-session -t $TMUX_SESSION_NAME
