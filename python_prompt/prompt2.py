#!/usr/bin/python

import urwid
import os
import syslog
server_list=os.getcwd()+'/.server.list'
bash='/bin/bash'

#set the choices var

def set_list(pos):
    list=[]
    servers={}
    key=1
    with open(server_list) as sl:
        for line in sl:
           servers[key]=line.split()
	   list.append(u''.join(servers[key][pos]))
	   key=key+1
    list=tuple(list)
    return list

choices = set_list(0)

#-----------------------------------

#set what to once option is set

def ssh_server(button,option):
    if option=='localhost':
	global exec_bash
	exec_bash=1
        exit_program()
    key=1
    options = {}
    with open(server_list) as f:
        for line in f:
            options[int(key)] = line.split()
            key=key+1
    key=1
    for i in options:
        if options[key][0]==option:
            privkey, user, url = options[key][1], options[key][2], options[key][3]
            ssh="ssh ","-i ",privkey, " ", user+"@"+url
            os.system("clear")
            os.system("".join(ssh))
            exit_program()
        key=key+1
#-------------------------------------


def menu(title, choices):
    body = [urwid.Text(title), urwid.Divider()]
    for c in choices:
        button = urwid.Button(c)
        urwid.connect_signal(button, 'click', ssh_server, c)
        body.append(urwid.AttrMap(button, None, focus_map='reversed'))
    return urwid.ListBox(urwid.SimpleFocusListWalker(body))

#exits the main loop
def exit_program():
    raise urwid.ExitMainLoop()

#main function, print the choices using the urwid lib, its a loop

main = urwid.Padding(menu(u'ssh traveling options', choices), left=2, right=2)
style = urwid.Overlay(main, urwid.SolidFill(' '),
    align='center', width=('relative', 60),
    valign='middle', height=('relative', 60),
    min_width=20, min_height=9)
urwid.MainLoop(style, palette=[('reversed', 'standout', '')]).run()

try:
    exec_bash
except:
    quit()
else:
    os.system(bash)
