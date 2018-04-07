module spam.config;
import std.typecons : Tuple;

struct Install {
	Tuple!(string, string)[] fonts;
	string[] saty;
	string[] hyph;
	string[] unidata;
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
	string[] depends;
}
