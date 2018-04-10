module spam.path;

import std.process : environment;
import std.path : expandTilde;
import std.string : join;

immutable string homedir;
//support only Posix and Windows
static this () {
	version(Windows) {
		homedir = environment.get("APPDATA") ~ "SATySFi\\spam";
	}
	else {
		homedir = "~/.spam".expandTilde;
	}
}

struct Path {
	immutable string[] path;
	immutable string real_path;
	this(immutable string[] path) {
		this.path = path;
		version(Windows) {
			real_path = homedir ~ "\\" ~ path.join("\\");
		}
		else {
			real_path = homedir ~ "/" ~ path.join("/");
		}
	}
}
