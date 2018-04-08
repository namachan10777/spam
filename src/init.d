module spam.init;

import std.path : expandTilde;
import std.file : exists, mkdir, tempDir, rmdirRecurse;
import std.stdio : stderr, writeln, File;
import std.process: execute;

import spam.path: Dir;
import spam.util: copyRec;
import spam.config: jsonOfDeps;

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
	Dir.home.expandTilde.mkdir;
	Dir.archive.expandTilde.mkdir;
	if ("~/.satysfi".expandTilde.exists) {
		if (initEnvFromLocal () != 0) return -1;
	}
	else {
		if (initEnvFromGithub () != 0) return -1;
	}
	copyRec("~/.spam/dist-origin/fonts".expandTilde, "~/.spam/fonts".expandTilde);
	copyRec("~/.spam/dist-origin/hash".expandTilde, "~/.spam/hash".expandTilde);
	copyRec("~/.spam/dist-origin/hyph".expandTilde, "~/.spam/hyph".expandTilde);
	copyRec("~/.spam/dist-origin/unidata".expandTilde, "~/.spam/unidata".expandTilde);
	auto systemDeps = File("~/.spam/installed.json".expandTilde, "w");
	systemDeps.writefln(jsonOfDeps([]).toString);
	return 0;
}
