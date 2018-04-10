module spam.io;

import std.algorithm.searching : any;
import std.file : exists, chdir, readText;
import std.process : execute;
import std.string : split;
import std.format : format;
import std.json : parseJSON;
import std.stdio : File;
import spam.config: parseConfig, depsOfJson, jsonOfDeps, Config;
import spam.path : Path;

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
	if (Path(["archiv", name.packname]).real_path.exists) {
		chdir(Path(["archive",name.packname]).real_path);
		execute(["git", "pull"]);
	}
	else {
		import std.stdio;
		execute(["git", "clone", name.full_url, Path(["archive",name.packname]).real_path]);
	}
}

void build(Path path, Config config) {
	chdir(path.real_path);
	foreach (cmd; config.build) {
		execute(cmd);
	}
}

//TODO remove package repo when install failed
void install(string url) {
	auto installed = Path(["installed.json"]).real_path.readText.parseJSON.depsOfJson;
	auto packname = url.complete_name;
	installed ~= packname.full_url;
	sync(packname);
	auto package_json_path = Path(["archive", packname.packname, "package.json"]);
	if (!package_json_path.real_path.exists) {
		throw new Exception("Invalid package");
	}
	else {
		auto config = package_json_path.real_path.readText.parseConfig;
		build(Path(["archive", packname.packname]), config);
		//copy_files(config);
	}
	auto installed_file = File(Path(["installed.json"]).real_path, "w");
	installed_file.writeln(installed.jsonOfDeps.toString);
}
