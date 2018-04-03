module spam.env;

import std.json : JSONValue;
import std.algorithm.iteration : map;
import std.range : array;

JSONValue jsonOfDeps (string[] names) {
	return JSONValue(names);
}

string[] depsOfJson(JSONValue json) {
	return json.array.map!(json => json.str).array;
}
