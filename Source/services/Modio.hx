package services;

import js.node.http.IncomingMessage;
import haxe.extern.EitherType;
import haxe.DynamicAccess;
import js.node.url.URL;
import haxe.http.HttpNodeJs;
import haxe.Http;

class Modio {
	static var game_id:Int = 34;
    public static function init(){
        
    }
    public static function getMods():Dynamic{
		var key = Bot.getModioKey();
        var data:Dynamic = null;
		var headers = new DynamicAccess<EitherType<String, Array<String>>>();
		headers.set("accept","application-json");
		var path = 'games/34/mods?api_key=' + key;

		var options:js.node.Https.HttpsRequestOptions = {
            host: "api.mod.io/v1/",
            path: path,
            port: 403,
            method: "GET",
            headers: headers
		};
		var req = js.node.Https.request(options, function(res:IncomingMessage) {
			res.on('data', function(all) {
				data += all;
			});
			res.on('end', function() {
                
			});
		});
		    req.on('error', function(e) {
                new BotError("MODIO ERROR : " + Std.string(e));
		    });
		    req.end();
            return data;
    }
}