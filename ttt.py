#!/usr/bin/python

import urwid
import syslog

#exits the main loop
def exit_program():
    raise urwid.ExitMainLoop()

table={'col0':['a0', 'b0', 'c0'], 'col1':['a1', 'b1', 'c1'], 'col2':['a2', 'b2', 'c2']}

def next_move(button, c):
   print c 
def menu(title, table):
    body = [urwid.Text(title), urwid.Divider()]
    for c in table:
        button = urwid.Button(c)
        urwid.connect_signal(button, 'click', next_move, c)
        body.append(urwid.AttrMap(button, 'middle', focus_map='reversed'))
    for c in table:
        button = urwid.Button(c)
        urwid.connect_signal(button, 'click', next_move, c)
        body.append(urwid.AttrMap(button, None, focus_map='reversed'))
    print (body)
    return urwid.ListBox(urwid.SimpleFocusListWalker(body))

main = urwid.Padding(menu(u'Tic Tac Toe', [table['col'+str(col)][0] for col in xrange(3)]), left=2, right=2)
main2 = urwid.Padding(menu(u'Tic Tac Toe', [table['col'+str(col)][1] for col in xrange(3)]), left=2, right=2)
#main3 = urwid.Padding(menu(u'Tic Tac Toe', [table['col'+str(col)][2] for col in xrange(3)]), left=2, right=2)
over = urwid.Overlay(main, main2,
    align='center', width=('relative', 60),
    valign='middle', height=('relative', 60),
    min_width=20, min_height=9)
#over_over = urwid.Overlay(over, main3,
#    align='center', width=('relative', 60),
#    valign='middle', height=('relative', 60),
#    min_width=20, min_height=9)

urwid.MainLoop(over).run()

try:
    exec_bash
except:
    quit()
else:
    os.system(bash)
