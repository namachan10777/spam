module spam.init;

import std.path : expandTilde;
import std.file : exists, mkdir, tempDir, rmdirRecurse;
import std.stdio : stderr, writeln, File;
import std.process: execute;

import spam.path: Dir;
import spam.util: copyRec;
import spam.env: Dep, jsonOfDeps;

int initEnvFromGithub () {
	auto gitStatus = execute(["git", "clone", "https://github.com/gfngfn/satysfi", tempDir()~"/satysfi"]);
	if (gitStatus.status != 0) {
		stderr.writeln("init failed. git exited with code %s.", gitStatus.status);
		return -1;
	}
	copyRec("/tmp/satysfi/lib-satysfi/dist", "~/.spam/dist-origin".expandTilde);
	rmdirRecurse("/tmp/satysfi");
	return 0;
}

int initEnvFromLocal () {
	copyRec("~/.satysfi/dist".expandTilde, "~/.spam/dist-origin".expandTilde);
	return 0;
}

int init() {
	if (Dir.home.expandTilde.exists) {
		stderr.writeln("init failed. directory ~/.spam is already exists.");
		return -1;
	}
	mkdir (Dir.home.expandTilde);
	mkdir (Dir.env.expandTilde);
	mkdir (Dir.archive.expandTilde);
	auto gitStatus = execute(["git", "clone", "https://github.com/namachan10777/spam-repository", Dir.index.expandTilde]);
	if (gitStatus.status != 0) {
		stderr.writefln("init failed. git exited with code %s.", gitStatus.status);
		return -1;
	}
	if ("~/.satysfi".expandTilde.exists) {
		if (initEnvFromLocal () != 0) return -1;
	}
	else {
		if (initEnvFromGithub () != 0) return -1;
	}
	copyRec("~/.spam/dist-origin".expandTilde, "~/.spam/env/system".expandTilde);
	auto currentEnv = File("~/.spam/current.txt".expandTilde, "w");
	auto systemDeps = File("~/.spam/env/system/env.json".expandTilde, "w");
	currentEnv.writeln("system");
	systemDeps.writefln(jsonOfDeps([]).toString);
	return 0;
}
