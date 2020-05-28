package lib;
import haxe.Log;
import haxe.ds.StringMap;
import hscript.*;
class EvalHandler {
    public function new() {
		interp = new Interp();
		parser = new Parser();
		loadVars(interp.variables);
    }
    public var interp:Interp;
    public var parser:Parser;
    function loadVars(v:StringMap<Dynamic>){
        v.clear();
        v.set("Math",Math);
        v.set("trace",doTrace);
        v.set("Logger",lib.Settings.Logger);
        v.set("Settings",lib.Settings);
        v.set("Type",Type);
        v.set("Reflect",Reflect);
    }
    var logs:Array<String>;
    public function doTrace(s:Dynamic){
        var tmp = Std.string(s);
        logs.push(tmp);
    }
    public function evaluate(s:String,?loc:StringMap<Dynamic>) {
        loadVars(interp.variables);
        if(loc != null){
            for(o in loc.keys()){
                interp.variables.set(o,loc.get(o));
            }
        }
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