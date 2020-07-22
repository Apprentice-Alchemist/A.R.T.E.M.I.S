package lib;
import haxe.crypto.Sha224;
import haxe.crypto.Sha1;
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
        v.set("true",true);
        v.set("false",false);
        v.set("null",null);
        v.set("Math",Math);
        v.set("trace",doTrace);
        v.set("Logger",lib.Logger);
        v.set("Settings",lib.Settings);
        v.set("Type",Type);
        v.set("Reflect",Reflect);
        v.set("Bot",Bot);
        v.set("CommandHandler",CommandHandler);
        v.set("MessageHandler",MessageHandler);
        v.set("EReg",EReg);
        v.set("getVars",function(){
            return interp.variables;
        });
        
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