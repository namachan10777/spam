module spam.app;

import std.stdio;

import spam.help;
import spam.init: init;
import spam.io : install;

enum VERSION = "yet released";

void main(string[] args) {
	if (args.length < 2) {
		show_help();
		return;
	}
	switch (args[1]) {
	case "--version":
		writeln(VERSION);
		break;
	case "-v":
		writeln(VERSION);
		break;
	case "--help":
		show_help();
		break;
	case "-h":
		show_help();
		break;
	case "init":
		init();
		break;
	case "list":
		stderr.writeln("yet implemented");
		break;
	case "show":
		stderr.writeln("yet implemented");
		break;
	case "install":
		if (args.length == 2) {
			writeln("spam install required argments");
			"install".show_subcommand_help;
		}
		install(args[2]);
		break;
	case "remove":
		stderr.writeln("yet implemented");
		break;
	case "update":
		stderr.writeln("yet implemented");
		break;
	case "upgrade":
		stderr.writeln("yet implemented");
		break;
	case "switch":
		stderr.writeln("yet implemented");
		break;
	case "pin":
		stderr.writeln("yet implemented");
		break;
	case "help":
		if (args.length <= 2)
			show_help();
		else
			show_subcommand_help(args[2]);
		break;
	default:
		writefln("invalid command name or option: %s", args[1]);
		show_help();
	}
}
