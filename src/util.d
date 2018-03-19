module spam.util;
/*
parent/
|
+--daughter/
   |
   +--grandson

copyRec("parent/daughter", "parent/son");

parent/
|
+--son/
|  |
|  +--grandson
|
+--daughter/
   |
   +--grandson
*/

void copyRec (string from, string to) {
	import std.array : replace;
	import std.file;
	import std.format: format;
	if (!from.exists) throw new FileException(format("File not found %s", from));
	if (   to.exists) throw new FileException(format("%s is already exists", to));
	if (from.isFile) copy(from, to);
	else if (from.isDir) {
		mkdir(to);
		foreach(DirEntry entry; from.dirEntries(SpanMode.shallow)) {
			copyRec(entry.name, entry.name.replace(from, to));
		}
	}
	else if (from.isSymlink) {
		version(Posix) {
			symlink(readLink(from), to);
		}
		else {
			throw new FileException ("symlink support is posix only.");
		}
	}
}
