package lib;


import sys.io.File;

class Logger {
	public static function addLog(v, ?infos) {
		File.saveContent("logs.txt", File.getContent("logs.txt") + "\n" + haxe.Log.formatOutput(v, infos));
	}

	public static var oldTrace:Dynamic;

	public static function setTrace() {
		oldTrace = haxe.Log.trace;
		haxe.Log.trace = function(v, ?infos) {
			addLog("[" + Date.now().toString() + "] " + v, infos);
			oldTrace("[" + Date.now().toString() + "] " + v, infos);
		}
		if (!sys.FileSystem.exists("logs.txt")) {
			File.saveContent("logs.txt", "");
		}
	}
}
