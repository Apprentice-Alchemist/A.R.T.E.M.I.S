package lib;

import haxe.Json;
import haxe.Http;

class Modio {
	public static var mods_json:Dynamic;
	public static function getMods(?cb:(e:Dynamic)->Void){getModioData("games/34/mods",cb);}	
	// public static function getMod(?cb:(e:String)->Void){
	// 	getModioData("games/")
	// }
	public static function getModioData(_path:String, ?cb:(e:Dynamic) -> Void){
		makeRequest("https://api.mod.io/v1/" + _path + '?api_key=' + Bot.getModioKey(),cb);
		
	}
	public static function makeRequest(full_path, ?cb:(e:Dynamic) -> Void){
		var req = new Http(full_path);
		req.setHeader("Content-Type", "application-json");
		req.addParameter("port", "443");
		req.onData = function(e) {
			cb(e);
		};
		req.onError = function(e) {
			trace("Modio Error : " + e);
		};
		req.onStatus = function(e) {
			trace("Modio Status : " + e);
		};
		req.request();
	}
}