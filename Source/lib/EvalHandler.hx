package lib;
import haxe.Log;
import haxe.ds.StringMap;
import hscript.*;
class EvalHandler {
    public static var interp:Interp;
    public static var parser:Parser;
    public static function init(){
        interp = new Interp();
        parser = new Parser();
        loadVars(interp.variables);
    }
    static function loadVars(v:StringMap<Dynamic>){
        v.set("Math",Math);
        v.set("trace",doTrace);
        v.set("Logger",lib.Settings.Logger);
        v.set("Settings",lib.Settings);
    }
    static var logs:Array<String>;
    public static function doTrace(s:Dynamic){
        var tmp = Std.string(s);
        logs.push(tmp);
    }
    public static function evaluate(s:String) {
        logs = new Array<String>();
        var p = parser.parseString(s);
        if (p == null){return null;}
        var tmp = interp.execute(p);
        var b = new StringBuf();
        for(o in logs){
            b.add(o + "\n");
        }
        b.add(Std.string(tmp));
        return b.toString();
    }
}