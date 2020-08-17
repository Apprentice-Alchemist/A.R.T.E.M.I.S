package lib;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;

class JsonHandler {
	public static inline function canRead(file:String) {
		return FileSystem.exists(file);
	}

	static inline function log<T>(msg:String, val:T):T {
		trace(msg);
		return val;
	}

	/**
		Reads the contents of the file and returns an anonymous object.
		@param file -the path to the file
	**/
	public static function read(file:String):Dynamic {
		var content = "";
		if (canRead(file)) {
			content = try File.getContent(file) catch (e:Dynamic) log('Could not read file $file', "");
		}
		return try Json.parse(content) catch (e) log('Could not parse json from file $file', {});
	}

	/**
		Write json content to a file.
		@param file -the path to the file
		@param s -the json you want to write
	**/
	public static function write(file:String, s:Dynamic) {
		try
			File.saveContent(file, Json.stringify(s))
		catch (e:Dynamic)
			trace('Error while writing file $file');
	}
}
