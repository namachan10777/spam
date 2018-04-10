module spam.init;

import std.file : exists, mkdir, tempDir, rmdirRecurse;
import std.stdio : stderr, writeln, File;
import std.process: execute;

import spam.path: Path;
import spam.util: copyRec;
import spam.config: jsonOfDeps;

int initEnvFromGithub () {
	auto gitStatus = execute(["git", "clone", "https://github.com/gfngfn/satysfi", tempDir()~"/satysfi"]);
	if (gitStatus.status != 0) {
		stderr.writeln("init failed. git exited with code %s.", gitStatus.status);
		return -1;
	}
	copyRec("/tmp/satysfi/lib-satysfi/dist", Path(["dist-origin"]).real_path);
	rmdirRecurse("/tmp/satysfi");
	return 0;
}

int initEnvFromLocal () {
	copyRec(Path(["dist"]).real_path, Path(["dist-origin"]).real_path);
	return 0;
}

int init() {
	if (Path([]).real_path.exists) {
		stderr.writeln("init failed. directory ~/.spam is already exists.");
		return -1;
	}
	Path([]).real_path.mkdir;
	Path(["archive"]).real_path.mkdir;
	if (Path([]).real_path.exists) {
		if (initEnvFromLocal () != 0) return -1;
	}
	else {
		if (initEnvFromGithub () != 0) return -1;
	}
	copyRec(Path(["dist-origin","fonts"]).real_path,   Path(["dist-origin","fonts"]).real_path);
	copyRec(Path(["dist-origin","hash"]).real_path,    Path(["dist-origin","hash"]).real_path);
	copyRec(Path(["dist-origin","hyph"]).real_path,    Path(["dist-origin","hyph"]).real_path);
	copyRec(Path(["dist-origin","unidata"]).real_path, Path(["dist-origin","unidata"]).real_path);
	auto systemDeps = File(Path(["installed.json"]).real_path, "w");
	systemDeps.writefln(jsonOfDeps([]).toString);
	return 0;
}
