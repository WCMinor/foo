import urwid
import os
import syslog
server_list=os.getcwd()+'/.server.list'
bash='/opt/local/bin/bash'

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

def ssh_server(button,option):
    if option=='localhost':
        exit_program(1)
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
	    h="".join(ssh)
            syslog.syslog(syslog.LOG_NOTICE, h)
	    os.system("clear")
            os.system("".join(ssh))
	    exit_program(1)
        key=key+1

def menu(title, choices):
    body = [urwid.Text(title), urwid.Divider()]
    for c in choices:
        button = urwid.Button(c)
        urwid.connect_signal(button, 'click', ssh_server, c)
        body.append(urwid.AttrMap(button, None, focus_map='reversed'))
    return urwid.ListBox(urwid.SimpleFocusListWalker(body))

def exit_program(button):
    raise urwid.ExitMainLoop()

main = urwid.Padding(menu(u'SSH traveling options', choices), left=2, right=2)
top = urwid.Overlay(main, urwid.SolidFill(u'\N{MEDIUM SHADE}'),
    align='center', width=('relative', 60),
    valign='middle', height=('relative', 60),
    min_width=20, min_height=9)
urwid.MainLoop(top, palette=[('reversed', 'standout', '')]).run()
os.system(bash)
