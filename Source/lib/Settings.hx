package lib;

import haxe.io.Output;
import sys.FileSystem;
import haxe.Log;
import sys.io.File;
import haxe.Json;

class Settings {
	static var _settings:Dynamic;
	public static function load(){
		if (!FileSystem.exists("settings.json")) {
			File.saveContent("settings.json", "{users:[],guild:[]}");
		}
		_settings = Json.parse(File.getContent("settings.json"));
	}
	public static function save(){
		File.saveContent("settings.json",Json.stringify(_settings));
	}
	public static function set(t:Dynamic,value:Dynamic){
		t = value;
		save();

	}
	public static function getUser(id:String) {
		
	}
	public static function getGuild(id:String) {}
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
