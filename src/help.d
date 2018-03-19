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

void show_subcommand_help(string cmd) {
	switch (cmd) {
	case "init":
		show_init_help();
		break;
	case "list":
		show_list_help();
		break;
	case "show":
		show_show_help();
		break;
	case "install":
		show_init_help();
		break;
	case "remove":
		show_remove_help();
		break;
	case "update":
		show_update_help();
		break;
	case "upgrade":
		show_upgrade_help();
		break;
	case "switch":
		show_switch_help();
		break;
	case "pin":
		show_pin_help();
		break;
	case "help":
		show_help();
		break;
	default:
		writefln("invalid command name %s", cmd);
	}
}

void show_init_help () {
	writefln("init");
	writefln("");
	writefln("usage:");
	writefln("    spam init");
	writefln("description");
	writefln("    %s", INIT_DSCR);
}

void show_list_help () {
	writefln("list");
	writefln("");
	writefln("usage:");
	writefln("    spam list");
	writefln("description");
	writefln("    %s", LIST_DSCR);
}

void show_show_help () {
	writefln("show");
	writefln("");
	writefln("usage:");
	writefln("    spam list PACKAGES...");
	writefln("PACKAGES:");
	writefln("    list of packages name.");
	writefln("description");
	writefln("    %s", SHOW_DSCR);
}

void show_install_help () {
	writefln("install");
	writefln("");
	writefln("usage:");
	writefln("    spam install [-y|--yes] PACKAGES...");
	writefln("PACKAGES:");
	writefln("    list of packages name.");
	writefln("-y --yes");
	writefln(" Disable interactive mode and answer yes to all questions that would otherwise be asked to the user.");
	writefln("description");
	writefln("    %s", INSTALL_DSCR);
}

void show_remove_help () {
	writefln("remove");
	writefln("");
	writefln("usage:");
	writefln("    spam remove [-y|--yes] PACKAGES...");
	writefln("PACKAGES:");
	writefln("    list of packages name.");
	writefln("-y --yes");
	writefln(" Disable interactive mode and answer yes to all questions that would otherwise be asked to the user.");
	writefln("description");
	writefln("    %s", REMOVE_DSCR);
}

void show_update_help () {
	writefln("remove");
	writefln("");
	writefln("usage:");
	writefln("    spam update");
	writefln("description");
	writefln("    %s", UPDATE_DSCR);
}

void show_upgrade_help () {
	writefln("upgrade");
	writefln("");
	writefln("usage:");
	writefln("    spam upgrade [-y|--yes]");
	writefln("-y --yes");
	writefln(" Disable interactive mode and answer yes to all questions that would otherwise be asked to the user.");
	writefln("description");
	writefln("    %s", UPGRADE_DSCR);
}

void show_switch_help () {
	writefln("switch");
	writefln("");
	writefln("usage:");
	writefln("    spam switch ENVNAME ");
	writefln("ENVNAME:");
	writefln("    Environment name. Default environment is 'default'");
	writefln("description");
	writefln("    %s", SWITCH_DSCR);
}

void show_pin_help () {
	writefln("pin");
	writefln("");
	writefln("usage:");
	writefln("    spam pin PACKAGE [PATH|VERSION]");
	writefln("PACKAGE:");
	writefln("    Package name.");
	writefln("PATH:");
	writefln("    Package source repository path");
	writefln("VERSION:");
	writefln("    Package version specification. e.g '>=1.0.0', '1.2.1.'");
	writefln("description");
	writefln("    %s", PIN_DSCR);
}
