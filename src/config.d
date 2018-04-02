module spam.config;
import std.typecons : Tuple;

struct Install {
	Tuple!(string, string)[] fonts;
	string[] saty;
	string[] hyph;
	string[] unidata;
}

enum CondType {
	And,
	Or,
	Gret,
	Less,
	Eq,
	Not
}

class Cond {
	CondType type;
	string ver;
	Cond right_exp, left_exp;
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
	string ver;
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
