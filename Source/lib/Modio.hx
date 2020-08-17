package lib;

import js.node.url.URL;
import haxe.DynamicAccess;
import js.node.Https;
import haxe.Json;
import haxe.Http;

class Modio {
	public static var mods_json:Dynamic;
	// public static function getMods(?cb:(e:Dynamic)->Void){getModioData("games/34/mods",cb);}	
	// public static function getMod(?cb:(e:String)->Void){
	// 	getModioData("games/")
	// }
	// public static function getModioData(_path:String, ?cb:(e:Dynamic) -> Void){
	// @:privateAccess	makeRequest("https://api.mod.io/v1/" + _path + '?api_key=' + Bot.getModioKey(),cb);
		// 
	// }
	public static function makeRequest(full_path){
		var promise = new TPromise<Dynamic>();
		var req = new haxe.http.HttpNodeJs(full_path);
		req.addParameter("port", "443");
		req.onData = function(e) {
			trace("Modio Data");
			promise.resolve(e);
		};
		req.onError = function(e) {
			trace("Modio Error : " + e);
			promise.reject(e);
		};
		req.onStatus = function(e) {
			trace("Modio Status : " + e);
		};
		req.request();
		// req.
		return promise;
	}
}