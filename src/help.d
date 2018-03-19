module spam.help;

import std.stdio;

enum INIT_DSCR = "Initialize SPAM state.";
enum LIST_DSCR = "Display the list of available packages.";
enum SHOW_DSCR = "Display information about specific packages.";
enum INSTALL_DSCR = "Install a list of packages.";
enum REMOVE_DSCR = "Remove a list of packages.";
enum UPDATE_DSCR = "Update the list of available packages.";
enum UPGRADE_DSCR = "Upgrade the installed package to latest version.";
enum SWITCH_DSCR = "Manage multiple environments.";
enum PIN_DSCR = "Pin a given package to specific version or source";


void show_help () {
	writefln("usage: spam [--version]");
	writefln("            [--help]");
	writefln("            <command> [<args>]");
	writefln("spam commands are");
	writefln("    init     %s", INIT_DSCR);
	writefln("    list     %s", LIST_DSCR);
	writefln("    show     %s", SHOW_DSCR);
	writefln("    install  %s", INSTALL_DSCR);
	writefln("    remove   %s", REMOVE_DSCR);
	writefln("    update   %s", UPDATE_DSCR);
	writefln("    upgrade  %s", UPGRADE_DSCR);
	writefln("    switch   %s", SWITCH_DSCR);
	writefln("    pin      %s", PIN_DSCR);
	writefln("See 'spam help <command>' for more information on a specific command.", PIN_DSCR);
}
