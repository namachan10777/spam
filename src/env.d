module spam.env;

import std.json : JSONValue;

struct Dep {
	string name;
	string ver;
}

JSONValue jsonOfDeps (Dep[] deps) {
	JSONValue json;
	foreach(dep; deps) {
		json.object[dep.name] = dep.ver;
	}
	return json;
}

Dep[] depsOfJson(JSONValue json) {
	Dep[] deps;
	foreach(name; json.object.keys) {
		deps ~= Dep(name, json.object[name].str);
	}
	return deps;
}
