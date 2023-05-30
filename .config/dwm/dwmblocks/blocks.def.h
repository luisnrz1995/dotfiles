//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/        /*Command*/         /*Update Interval*/		/*Update Signal*/
	{"",            "sb-network",       1,                      0},
	{"",            "sb-battery",       1,                      0},
	{"",            "sb-cpu",           1,                      0},
	{"",            "sb-temperature",   1,                      0},
	{"",            "sb-volume",        0,                      10},
	{"",            "sb-brightness",    0,                      20},
	{"",            "sb-clock",         1,                      0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 3;
