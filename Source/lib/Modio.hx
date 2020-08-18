package lib;

import js.node.url.URL;
import haxe.DynamicAccess;
import js.node.Https;
import haxe.Json;
import haxe.Http;

class Modio {
	public static function makeRequest(full_path)
		return new js.lib.Promise(function(resolve, reject) {
			var req = new haxe.http.HttpNodeJs(full_path);
			req.addParameter("port", "443");
			req.onData = function(e) {
				trace("Modio Data");
				resolve(e);
			};
			req.onError = function(e) {
				trace("Modio Error : " + e);
				reject(e);
			};
			req.onStatus = function(e) {
				trace("Modio Status : " + e);
			};
			req.request();
		});
}
