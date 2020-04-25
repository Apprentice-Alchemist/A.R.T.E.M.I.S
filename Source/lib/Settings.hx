package lib;

import haxe.Json;

class Settings {
    public static var oldTrace:Dynamic;
    public static function setTrace(){
        oldTrace = haxe.Log.trace;
        haxe.Log.trace = function(v,?infos){
            addLog(v,infos);
            oldTrace("Logged!");
			oldTrace(v,infos);
        }
    }

    public static var logs:Logs = {
        logs: []
    }
    public static function loadLogs() {
        logs = getLogs();
    }
    public static function addLog(v,?infos){
        logs.logs.push(haxe.Log.formatOutput(v,infos));
        JsonHandler.write("logs.json",Json.stringify(logs));
    }
    public static function getLogs():Logs{
        var tmp = JsonHandler.read("logs.json");
        if(tmp == null || tmp == "") return {logs: []}
        return Json.parse(tmp);
    }
    public static function formatLogs():Array<String>{
        var tmp = logs.logs.join("\n");
        var length = tmp.length;
        var max = 2000 - 10;
        var tmp2 = length/max;
        var tmp3 = Math.ceil(tmp2);
        var r = [];
        trace(tmp);
        for(o in 0...tmp3){
            r.push("```\n" + tmp.substring(max*o,max*(o + 1)) + "\n```");
        }
        return r;
    }
    public static function clearLogs() {
        logs = {logs: []};
        JsonHandler.write("logs.json","");
    }
    static function getUser(id:String){

    }
    static function getGuild(id:String){
          
    }
}
typedef Logs = {
    logs:Array<String>
}
