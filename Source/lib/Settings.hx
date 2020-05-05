package lib;

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
		// if (logs == null)
		// 	logs = getLogData();
		// if (logs.logs == null)
		// 	logs = getLogData();
        logs.logs.push(haxe.Log.formatOutput(v, infos));
        save();
	}

	public static function getLogData():Logs {
		var tmp = JsonHandler.read("logs.json");
		return cast tmp;
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
}
typedef Logs = {
    logs:Array<String>
}
