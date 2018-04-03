module spam.config;
import std.typecons : Tuple;

struct Install {
	Tuple!(string, string)[] fonts;
	string[] saty;
	string[] hyph;
	string[] unidata;
}

enum CondType {
	Gret,
	Less,
	Eq,
	GretEq,
	LessEq
}

struct Cond {
	CondType type;
	string ver;
}

enum DepType {
	Build,
	Always
}

struct Dep {
	string name;
	DepType type;
	Cond cond;
}

struct Config {
	string spam_ver;
	string[] authors;
	string maintainer;
	string homepage;
	string bug_reports;
	string dev_repo;
	string license;
	string[][] build;
	Install install;
	Dep[] depends;
}
