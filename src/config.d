module spam.config;
import std.typecons : Tuple, tuple;
import std.json : parseJSON, JSONValue;
import std.algorithm.iteration : map;
import std.range : array;

JSONValue jsonOfDeps (string[] names) {
	return JSONValue(names);
}

string[] depsOfJson(JSONValue json) {
	return json.array.map!(json => json.str).array;
}

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

Config parseConfig (string str) {
	auto json = parseJSON(str);
	Config config;
	//optional field
	if ("spam-version" in json.object) config.spam_ver    = json.object["spam-version"].str;
	if ("homepage"     in json.object) config.homepage    = json.object["homepage"].str;
	if ("bug-reports"  in json.object) config.bug_reports = json.object["bug-reports"].str;
	if ("dev-repo"     in json.object) config.dev_repo    = json.object["dev-repo"].str;
	if ("build"        in json.object) {
		foreach (step; json.object["build"].array) {
			config.build ~= step.array.map!(json => json.str).array;
		}
	}
	if ("depends"      in json.object) {
		foreach (dep_name; json.object["depends"].array) {
			config.depends ~= dep_name.str;
		}
	}
	//required field
	if ("maintainer"   in json.object) config.maintainer  = json.object["maintainer"].str;
	else throw new Exception("missing required field \"maintainer\"");
	if ("license"      in json.object) config.license     = json.object["license"].str;
	else throw new Exception("missing required field \"license\"");
	if ("authors"      in json.object) {
		auto authors = json.object["authors"];
		foreach (author; authors.array) {
			config.authors ~= author.str;
		}
	}
	else throw new Exception("missing required field \"authors\"");
	if ("install"      in json.object) {
		auto install_json = json.object["install"];
		config.install.saty    = install_json.object["saty"   ].array.map!(json => json.str).array;
		config.install.hyph    = install_json.object["hyph"   ].array.map!(json => json.str).array;
		config.install.unidata = install_json.object["unidata"].array.map!(json => json.str).array;
		auto fonts_json   = install_json.object["fonts"];
		foreach (key; fonts_json.object.keys) {
			config.install.fonts ~= tuple(key, fonts_json[key].str);
		}
	}
	else throw new Exception("missing required field \"install\"");

	return config;
}
unittest {
	auto text = q{
		{	
			"spam-version": "1.2",
			"version": "0.3.1",
			"authors": ["Nakano Masaki <namachan10777@gmail.com>"],
			"maintainer": "Nakano Masaki <namachan10777@gmail.com>",
			"homepage": "https://github.com/namachan10777/spam",
			"bug-reports": "https://github.com/namachan10777/spam/issues",
			"dev-repo": "https://github.com/namachan10777/spam.git",
			"license": "LGPL-3.0",
			"build": [
				[ "echo", "building" ]
			],
			"install": {
				"fonts":{
					"hoge":"path/to/hoge.otf"
				},
				"saty":[
					"path/to/saty.saty"
				],
				"hyph":[
					"path/to/hyph"
				],
				"unidata":[
					"path/to/unidata"
				]
			},
			"depends": [
				"foo/bar"
			]
		}
	};
	auto config = text.parseConfig;
	assert (config.spam_ver == "1.2");
	assert (config.authors == ["Nakano Masaki <namachan10777@gmail.com>"]);
	assert (config.maintainer == "Nakano Masaki <namachan10777@gmail.com>");
	assert (config.homepage == "https://github.com/namachan10777/spam");
	assert (config.bug_reports == "https://github.com/namachan10777/spam/issues");
	assert (config.dev_repo == "https://github.com/namachan10777/spam.git");
	assert (config.license == "LGPL-3.0");
	assert (config.build == [["echo", "building"]]);
	assert (config.install == Install([tuple("hoge", "path/to/hoge.otf")], ["path/to/saty.saty"], ["path/to/hyph"], ["path/to/unidata"]));
	assert (config.depends == ["foo/bar"]);
}
