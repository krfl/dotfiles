"""Custom tab bar for kitty - ported from wezterm dashboard tab bar.

Draws tabs with nerd font process icons and a right-aligned status bar
showing the current directory, git branch, and clock.
"""

import os
from datetime import datetime

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int

# Nerd Font icons for foreground processes
PROCESS_ICONS = {
    'fish':    '\U000f0773',
    'bash':    '\uebca',
    'zsh':     '\uea85',
    'nvim':    '\ue62b',
    'vim':     '\ue62b',
    'hx':      '\U000f03eb',
    'git':     '\ue702',
    'lazygit': '\ue702',
    'node':    '\U000f0399',
    'python':  '\ue73c',
    'python3': '\ue73c',
    'cargo':   '\ue7a8',
    'go':      '\U000f07d3',
    'docker':  '\ue7b0',
    'kubectl': '\U000f10fe',
    'ssh':     '\U000f048b',
    'htop':    '\U000f05b3',
    'btm':     '\U000f05b3',
    'make':    '\U000f0596',
    'claude':  '\U000f06a9',
}
DEFAULT_ICON = '\uea85'

FOLDER_ICON = '\U000f024b'
BRANCH_ICON = '\ue725'
CLOCK_ICON  = '\U000f0150'
SEP = '\u2502'


def _theme_color(opts, name, fallback):
    """Safely read a color attribute from kitty options."""
    try:
        return as_rgb(color_as_int(getattr(opts, name)))
    except (AttributeError, TypeError):
        return as_rgb(fallback)


def _get_tab_info(tab):
    """Get the foreground process name for a tab via the boss."""
    try:
        boss = get_boss()
        if boss:
            for tm in boss.os_window_id_map.values():
                t = tm.tab_for_id(tab.tab_id)
                if t is not None:
                    w = t.active_window
                    if w:
                        procs = w.child.foreground_processes
                        if procs:
                            cmdline = procs[-1].get('cmdline', [])
                            if cmdline:
                                return os.path.basename(cmdline[0])
                    break
    except Exception:
        pass
    return ''


def _abbreviate_path(path):
    """Shorten ~/a/b/c/d to .../c/d."""
    home = os.path.expanduser('~')
    if path.startswith(home):
        path = '~' + path[len(home):]
    if path.endswith('/') and len(path) > 1:
        path = path[:-1]
    parts = path.split('/')
    if len(parts) > 3:
        return '\u2026/' + '/'.join(parts[-2:])
    return path


def _get_git_branch(wd):
    """Read the git branch from .git/HEAD (no subprocess)."""
    if not wd:
        return ''
    d = wd
    while d != '/':
        head = os.path.join(d, '.git', 'HEAD')
        if os.path.isfile(head):
            try:
                with open(head) as f:
                    content = f.read().strip()
                if content.startswith('ref: refs/heads/'):
                    return content[16:]
                return content[:8]
            except Exception:
                return ''
        d = os.path.dirname(d)
    return ''


def _get_active_wd():
    """Get the working directory of the currently active window."""
    try:
        boss = get_boss()
        if boss and boss.active_tab:
            w = boss.active_tab.active_window
            if w:
                return getattr(w, 'cwd_of_child', '') or ''
    except Exception:
        pass
    return ''


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    opts = get_options()
    tab_bg = as_rgb(color_as_int(opts.tab_bar_background))

    if tab.is_active:
        name_fg = as_rgb(color_as_int(opts.active_tab_foreground))
        icon_fg = _theme_color(opts, 'color2', 0x8fae7a)  # green
    else:
        name_fg = as_rgb(color_as_int(opts.inactive_tab_foreground))
        icon_fg = name_fg

    exe = _get_tab_info(tab)
    icon = PROCESS_ICONS.get(exe, DEFAULT_ICON)
    title = exe if exe else 'shell'
    if len(title) > 12:
        title = title[:12] + '\u2026'

    screen.cursor.bg = tab_bg
    screen.cursor.fg = icon_fg
    screen.draw(f' {icon} ')
    screen.cursor.fg = name_fg
    screen.cursor.bold = tab.is_active
    screen.draw(title)
    screen.cursor.bold = False
    screen.draw(' ')

    if not is_last:
        screen.draw('  ')

    if is_last:
        _draw_right_status(screen, tab_bg, opts)

    return screen.cursor.x


def _draw_right_status(screen, bg, opts):
    """Draw cwd, git branch, and clock right-aligned in the tab bar."""
    yellow = _theme_color(opts, 'color3', 0xd4a574)
    green  = _theme_color(opts, 'color2', 0x8fae7a)
    stone  = _theme_color(opts, 'color6', 0xa89984)
    dim    = _theme_color(opts, 'color8', 0x585a50)

    parts = []
    wd = _get_active_wd()
    if wd:
        parts.append(('cwd', _abbreviate_path(wd)))
        branch = _get_git_branch(wd)
        if branch:
            parts.append(('git', branch))
    parts.append(('clock', datetime.now().strftime('%H:%M')))

    # Estimate width: sep(2) + each part(icon 2 + space 1 + text + gap 3)
    total_w = 2
    for _, text in parts:
        total_w += 2 + 1 + len(text) + 3

    remaining = screen.columns - screen.cursor.x
    if remaining < total_w + 2:
        return

    gap = remaining - total_w
    screen.cursor.bg = bg
    screen.draw(' ' * gap)

    screen.cursor.fg = dim
    screen.draw(f'{SEP} ')

    for i, (kind, text) in enumerate(parts):
        if kind == 'cwd':
            screen.cursor.fg = yellow
            screen.draw(f'{FOLDER_ICON} ')
            screen.cursor.fg = stone
            screen.draw(text)
        elif kind == 'git':
            screen.cursor.fg = green
            screen.draw(f'{BRANCH_ICON} {text}')
        elif kind == 'clock':
            screen.cursor.fg = yellow
            screen.draw(f'{CLOCK_ICON} ')
            screen.cursor.fg = stone
            screen.draw(text)
        if i < len(parts) - 1:
            screen.draw('   ')

    screen.draw(' ')
