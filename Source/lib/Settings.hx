package lib;

import js.html.idb.Database;
import haxe.crypto.Hmac;
import haxicord.endpoints.Endpoints;
import js.lib.webassembly.CompileError;
import haxe.macro.Compiler;
import haxicord.types.structs.Embed;
import haxicord.types.Channel;
import haxe.Json;

class Settings {
	static function getUser(id:String) {}
	static function getGuild(id:String) {}
}
class Logger{
	public static var logs:Logs;
    public static function save(){
        JsonHandler.write("logs.json",logs);
    }
	public static function addLog(v, ?infos) {
		if (logs == null)
			logs = getLogData();
		if (logs.logs == null)
			logs = getLogData();
        logs.logs.push(haxe.Log.formatOutput(v, infos));
        // save();
	}

	public static function getLogData():Logs {
		var tmp = JsonHandler.read("logs.json");
		return (tmp == null || tmp == "") ? {logs: []} : Json.parse(tmp);
	}

	public static function formatLogs():Array<String> {
		var tmp = logs.logs.join("\n");
		var length = tmp.length;
		var max = 2000 - 10;
		var tmp2 = length / max;
		var tmp3 = Math.ceil(tmp2);
		var r = [];
		trace(tmp);
		for (o in 0...tmp3) {
			r.push("```\n" + tmp.substring(max * o, max * (o + 1)) + "\n```");
		}
		return r;
	}

	public static function clearLogs() {
		logs = {logs: []};
		JsonHandler.write("logs.json", logs);
	}

	public static var oldTrace:Dynamic;
	public static function setTrace() {
		oldTrace = haxe.Log.trace;
		haxe.Log.trace = function(v, ?infos) {
			
			addLog("[" + Date.now().toString() + "] " + v, infos);
			oldTrace("[" + Date.now().toString() + "] " + v, infos);
		}
	}  
	public static function sendErrorToWebhook(err:String){
		var webhook:String = "https://discordapp.com/api/webhooks/705025393601675275/EdFYmO9qqhRce-nOZRbwBHFWl0x_WPYOJ9kKNTcxorJ69cFDi3SNBoNoWN3te3NT9MqV";
		var data:haxicord.endpoints.Typedefs.WebhookMessage = {
				embeds: new Array<Embed>()
		}
		data.embeds.push({color: 0x00ff00,title: "New Error!",timestamp: Date.now(),description: err,author: {name: "Artemis"}});
		var req = new haxe.Http(webhook);
		req.setHeader("Content-Type","application-json");
		req.setPostData(Json.stringify(data));
		req.onStatus = function(int){
			trace(int);
		};
		req.request(true);
	}
}
typedef Logs = {
    logs:Array<String>
}
// typedef WebhookMessage = {
// 	@:optional var content:String;
// 	@:optional var embeds:Array<Embed>;
// }
