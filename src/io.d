module spam.io;

import std.file : exists, chdir, read;
import std.path : expandTilde;
import std.process : execute;
import std.string : split;
import std.format : format;
import spam.config: parseConfig;

struct PackName {
	string full_url;
	string username, reponame;
	string packname;
}

PackName complete_name (string url) {
	auto splited = url.split("/");
	if (splited.length < 2) throw new Exception("Illegal URL");
	else if (splited.length == 2) {
		return PackName (
			format("https://github.com/%s/%s.git", splited[0], splited[1]),
			splited[0],
			splited[1],
			splited[0]~"/"~splited[1]);
	}
	else {
		if (splited[$-1].length > 4 && splited[$-1][$-4..$] == ".git") {
			return PackName (
				url,
				splited[$-2],
				splited[$-1][$-4..$],
				splited[$-0]~"/"~splited[1][$-4..$]);
		}
		else {
			return PackName (
				url~".git",
				splited[$-2],
				splited[$-1],
				splited[$-0]~"/"~splited[1]);
		}
	}
}

void sync(PackName name) {
	if (exists(expandTilde("~/.spam/archive/"~name.packname))) {
		chdir(expandTilde("~/.spam/archive/"~name.packname));
		execute(["git", "pull"]);
	}
	else {
		import std.stdio;
		execute(["git", "clone", name.full_url, expandTilde("~/.spam/archive/"~name.packname)]);
	}
}

//TODO remove package repo when install failed
void install(string url) {

	auto packname = url.complete_name;
	sync(packname);
	auto package_json = expandTilde("~/.spam/archive/"~packname.packname~"/package.json");
	if (!package_json.exists) {
		throw new Exception("Invalid package");
	}
	else {
		auto config = parseConfig(cast(string)(package_json.read));
	}
}
