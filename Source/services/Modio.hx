package services;

import js.node.url.URL;
import haxe.http.HttpNodeJs;
import haxe.Http;

class Modio {
	static var game_id:Int = 34;
    static var apikey:String;
    public static function init(){
        apikey = Bot.getModioKey();
    }
    public static function getMods(){
        // var key = apikey;
		// var options:js.node.Https.HttpsRequestOptions = {
		// 	host: 'api.mod.io',
		// 	port: 443,
		// 	path: '/v1/games/34/mods?api_key=' + apikey,
		// 	method: 'GET',
        //     headers: ['Accept','application-json']
        //       };
        // js.node.Https.request(options);
        // var http = new HttpNodeJs("https://api.mod.io/v1/game/34");
        
        // http.setHeader('Accept','application/json');
        
        // http.setParameter("api_key",key);
        // http.onData = function(s:String){
        //     trace(s);
        // }
        // http.onError = function(s:String){
        //     trace(s);
        // }
        // http.onStatus = function(s:Int){
        //     trace(s);
        // }
        // http.request();

        // // tmp.
    }
}