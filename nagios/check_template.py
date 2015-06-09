#!/usr/bin/env python

import sys
import argparse

STATE_OK = 0
STATE_WARNING = 1
STATE_CRITICAL = 2
STATE_UNKNOWN = 3

STATE_MESSAGE = "Failed -"
RETURN_STATE = STATE_OK

#2 Warn = 1 Critical
def return_state(state):
    global RETURN_STATE
    global STATE_MESSAGE
    RETURN_STATE += state
    print RETURN_STATE
    if RETURN_STATE > 1:
        STATE_MESSAGE +=" does not work"
        print STATE_MESSAGE
        sys.exit(STATE_CRITICAL)

return_state(1)
