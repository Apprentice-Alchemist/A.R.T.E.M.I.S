package lib;

import sys.FileSystem;
import haxe.Log;
import sys.io.File;
import haxe.Json;

class Settings {
	static function getUser(id:String) {}
	static function getGuild(id:String) {}
}
class Logger{
	public static function addLog(v, ?infos) {
		File.saveContent("logs.txt",File.getContent("logs.txt") + "\n" + Log.formatOutput(v,infos));
	}
	public static var oldTrace:Dynamic;
	public static function setTrace() {
		oldTrace = haxe.Log.trace;
		haxe.Log.trace = function(v, ?infos) {			
			addLog("[" + Date.now().toString() + "] " + v, infos);
			oldTrace("[" + Date.now().toString() + "] " + v, infos);
		}
		if(!FileSystem.exists("logs.txt")){
			File.saveContent("logs.txt","");
		}
	}
}
