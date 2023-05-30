/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 1; /* border pixel of windows */
static const unsigned int snap = 32; /* snap pixel */
static const unsigned int gappih = 2; /* horiz inner gap between windows */
static const unsigned int gappiv = 2; /* vert inner gap between windows */
static const unsigned int gappoh = 2; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov = 2; /* vert outer gap between windows and screen edge */
static const int smartgaps = 0; /* 1 means no outer gap when there is only one window */
static const unsigned int systraypinning = 1; /* 0: sloppy systray follows selected monitor, > 0: pin systray to monitor X */
static const unsigned int systrayonleft = 0; /* 0: systray in the right corner, > 0: systray on left of status text */
static const unsigned int systrayspacing = 3; /* systray spacing */
static const unsigned int systrayiconsize = 13; /* systray icon size in px */
static const int systraypinningfailfirst = 1; /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static int showsystray = 0; /* 0 means no systray */
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 1; /* 0 means bottom bar */
static const char *fonts[] = { "FiraCode Nerd Font:size=9.5" };
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_blue[] =  "#434C5E";
static const char *colors[][3] = {
  /*               fg          bg         border   */
  [SchemeNorm]   = {col_gray3, col_gray1, col_gray2},
  [SchemeSel]    = {col_gray4, col_blue,  col_blue},
  [SchemeTitle]  = {col_gray4, col_blue,  col_blue},
};
static const XPoint stickyicon[] = {{0, 0}, {4, 0}, {4, 8}, {2, 6}, {0, 8}, {0, 0}}; /* represents the icon as an array of vertices */
static const XPoint stickyiconbb = {4, 8}; /* defines the bottom right corner of the polygon's bounding box (speeds up scaling) */

typedef struct {
  const char *name;
  const void *cmd;
} Sp;

const char *spcmd1[] = {"alacritty", "--class", "spterm", "--config-file", "/home/luis/.config/alacritty/alacritty.yml", NULL };
const char *spcmd2[] = {"alacritty", "--class", "spfm", "--title", "ranger", "--config-file", "/home/luis/.config/alacritty/alacritty.yml", "-e", "ranger", NULL };
const char *spcmd3[] = {"alacritty", "--class", "spcmus", "--title", "cmus", "--config-file", "/home/luis/.config/alacritty/alacritty.yml", "-e", "cmus", NULL };
const char *spcmd4[] = {"alacritty", "--class", "sphtop", "--title", "htop", "--config-file", "/home/luis/.config/alacritty/alacritty.yml", "-e", "htop", NULL };

static Sp scratchpads[] = {
  /* name          cmd  */
  {"spterm",       spcmd1},
  {"spfm",         spcmd2},
  {"spcmus",       spcmd3},
  {"sphtop",       spcmd4},
};

static const char *const autostart[] = {
  "sh", "-c", "~/.config/dwm/autostart.sh", NULL,
  NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
  /* class                     instance        title                    tags mask     isfloating   monitor */
  { "Galculator",              NULL,           NULL,                    0,            1,           -1 },
  { "Gpick",                   NULL,           NULL,                    0,            1,           -1 },
  { "KeePassXC",               NULL,           NULL,                    0,            1,           -1 },
  { "Free Download Manager",   NULL,           NULL,                    0,            1,           -1 },
  { "firefox",                 "Toolkit",      NULL,                    0,            1,           -1 },
  { "firefox",                 "Browser",      NULL,                    0,            1,           -1 },
  { "firefox",                 "Places",       NULL,                    0,            1,           -1 },
  { "iriunwebcam",             NULL,           NULL,                    0,            1,           -1 },
  { "Connman-gtk",             NULL,           NULL,                    0,            1,           -1 },
  { NULL,                      NULL,           "Picture in picture",    0,            1,           -1 },
  { NULL,                      "spterm",       NULL,                    SPTAG(0),     1,           -1 },
  { NULL,                      "spfm",         "ranger",                SPTAG(1),     1,           -1 },
  { NULL,                      "spcmus",       "cmus",                  SPTAG(2),     1,           -1 },
  { NULL,                      "sphtop",       "htop",                  SPTAG(3),     1,           -1 },
};

/* layout(s) */
static const float mfact = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1; /* number of clients in master area */
static const int resizehints = 0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol         arrange function */
	{ "[]=",          tile },
	{ "[M]=",         monocle },
	{ "[floating]=",  NULL },
    { NULL,           NULL }
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]  = { "alacritty", "--class", "alacritty", NULL };

/* necessary to use the brightness and volume keys */
#include <X11/XF86keysym.h>

static const Key keys[] = {
    /* modifier                     key                                  function           argument */
    { MODKEY,                       XK_Return,                           spawn,             {.v = termcmd } },

    { MODKEY,                       XK_h,                                focusstack,        {.i = -1 } },
    { MODKEY,                       XK_l,                                focusstack,        {.i = +1 } },

    { MODKEY|ShiftMask,             XK_h,                                rotatestack,       {.i = -1 } },
    { MODKEY|ShiftMask,             XK_l,                                rotatestack,       {.i = +1 } },

    { MODKEY,                       XK_i,                                incnmaster,        {.i = +1 } },
    { MODKEY,                       XK_d,                                incnmaster,        {.i = -1 } },

    { MODKEY|Mod1Mask,              XK_h,                                setmfact,          {.f = -0.05} },
    { MODKEY|Mod1Mask,              XK_l,                                setmfact,          {.f = +0.05} },
    { MODKEY|Mod1Mask,              XK_n,                                setmfact,          {.f = 1.0 + mfact} },
    { MODKEY|Mod1Mask,              XK_j,                                setcfact,          {.f = -0.25} },
    { MODKEY|Mod1Mask,              XK_k,                                setcfact,          {.f = +0.25} },
    { Mod1Mask|MODKEY,              XK_n,                                setcfact,          {.f =  0.00} },

    { MODKEY,                       XK_Tab,                              view,              {0} },

    { MODKEY,                       XK_w,                                killclient,        {0} },

    { Mod1Mask,                     XK_t,                                setlayout,         {.v = &layouts[0]} },
    { Mod1Mask,                     XK_f,                                setlayout,         {.v = &layouts[1]} },
    { Mod1Mask,                     XK_m,                                setlayout,         {.v = &layouts[2]} },
    { MODKEY|ShiftMask,             XK_space,                            cyclelayout,       {.i = -1 } },
    { MODKEY,                       XK_space,                            cyclelayout,       {.i = +1 } },

    { MODKEY,                       XK_Right,                            viewnext,          {0} },
    { MODKEY,                       XK_Left,                             viewprev,          {0} },

    { MODKEY|ShiftMask,             XK_Right,                            tagtonext,         {0} },
    { MODKEY|ShiftMask,             XK_Left,                             tagtoprev,         {0} },

    { MODKEY|ShiftMask,             XK_f,                                togglefloating,    {0} },
    { Mod1Mask,                     XK_s,                                togglesticky,      {0} },
    { MODKEY|ShiftMask,             XK_s,                                togglesystray,     {0} },

    { ControlMask|Mod1Mask,         XK_t,                                togglescratch,     {.ui = 0 } },
    { ControlMask|Mod1Mask,         XK_r,                                togglescratch,     {.ui = 1 } },
    { ControlMask|Mod1Mask,         XK_m,                                togglescratch,     {.ui = 2 } },
    { ControlMask|Mod1Mask,         XK_h,                                togglescratch,     {.ui = 3 } },

    { MODKEY|ControlMask,           XK_r,                                quit,              {1} },
    { MODKEY|ControlMask,           XK_q,                                quit,              {0} },

    { MODKEY,                       XK_p,                                spawn,             SHCMD("dmenu_run -i -l 10 -p 'Run:'") },

    { 0,                            XF86XK_MonBrightnessUp,              spawn,             SHCMD("brightnessctl set +5%; pkill -RTMIN+20 dwmblocks") },
    { 0,                            XF86XK_MonBrightnessDown,            spawn,             SHCMD("brightnessctl set 5%-;pkill -RTMIN+20 dwmblocks") },

    { 0,                            XF86XK_AudioRaiseVolume,             spawn,             SHCMD("pamixer -i 5; pkill -RTMIN+10 dwmblocks") },
    { 0,                            XF86XK_AudioLowerVolume,             spawn,             SHCMD("pamixer -d 5; pkill -RTMIN+10 dwmblocks") },
    { 0,                            XF86XK_AudioMute,                    spawn,             SHCMD("pamixer -t; pkill -RTMIN+10 dwmblocks") },

    { MODKEY,                       XK_b,                                spawn,             SHCMD("firefox-esr") },
    { MODKEY,                       XK_f,                                spawn,             SHCMD("pcmanfm") },
    { MODKEY,                       XK_r,                                spawn,             SHCMD("alacritty --title 'ranger' -e ranger") },
    { MODKEY,                       XK_n,                                spawn,             SHCMD("alacritty --class 'nvim' -e nvim") },

    { 0,                            XK_Print,                            spawn,             SHCMD("screenshot") },
    { MODKEY,                       XK_Print,                            spawn,             SHCMD("screenshot --select") },
    { Mod1Mask,                     XK_Print,                            spawn,             SHCMD("screenshot --window") },

    { MODKEY,                       XF86XK_MonBrightnessUp,              spawn,             SHCMD("redshift LAT:LON") },
    { MODKEY,                       XF86XK_MonBrightnessDown,            spawn,             SHCMD("pkill redshift") },

    { MODKEY|ShiftMask,             XK_k,                                spawn,             SHCMD("dmkill") },
    { MODKEY|ShiftMask,             XK_e,                                spawn,             SHCMD("dmemoji") },
    { MODKEY|ShiftMask,             XK_x,                                spawn,             SHCMD("dmpower") },

    { MODKEY,                       XK_period,                           spawn,             SHCMD("slock") },

    TAGKEYS(                        XK_1,                                0)
    TAGKEYS(                        XK_2,                                1)
    TAGKEYS(                        XK_3,                                2)
    TAGKEYS(                        XK_4,                                3)
    TAGKEYS(                        XK_5,                                4)
    TAGKEYS(                        XK_6,                                5)
    TAGKEYS(                        XK_7,                                6)
    TAGKEYS(                        XK_8,                                7)
    TAGKEYS(                        XK_9,                                8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
