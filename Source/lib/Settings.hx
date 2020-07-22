package lib;

import haxe.Serializer;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

class Settings {
	static var _settings(get,null):SettingsImpl;
	static function get__settings():SettingsImpl{
		if(_settings == null){
			return load();
		}else{
			return _settings;
		}
	}
	public static function load() {
		if (!FileSystem.exists("settings.json")) {
			File.saveContent("settings.json", Json.stringify({
				users: new Map<String,{}>(),
				guilds: new Map<String,{}>(),
				global: {}
			}));
		}
		return Json.parse(File.getContent("settings.json"));
	}

	public static function save() {
		File.saveContent("settings.json", Json.stringify(_settings));
	}

	public static function set(t:Dynamic, value:Dynamic) {
		t = value;
		save();
	}

	public static function getUser(id:String) {
		if(!_settings.users.exists(id)){
			_settings.users.set(id,new UserSettings());
		}
		return _settings.users.get(id);
	}

	public static function getGuild(id:String) {
		if (!_settings.guilds.exists(id)) {
			_settings.guilds.set(id, new GuildSettings());
		}
		return _settings.guilds.get(id);
	}
}
typedef SettingsImpl = {
	var users:Map<String,UserSettings>;
	var guilds:Map<String,GuildSettings>;
	var global:GlobalSettings;
}
typedef UserSettings = Map<String, String>;

typedef GuildSettings = Map<String,String>;

typedef GlobalSettings = {}

