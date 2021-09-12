import subprocess
from kitty.boss import Boss
from kitty.window import Window

def on_close(boss, window, data):
    tab = boss.active_tab
    if tab is not None and tab.current_layout.name == 'stack':
        tab.last_used_layout()
