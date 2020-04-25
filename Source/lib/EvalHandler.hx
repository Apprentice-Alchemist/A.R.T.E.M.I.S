package lib;
import haxe.Log;
import haxe.ds.StringMap;
import hscript.*;
class EvalHander {
    public static var interp:Interp;
    public static var parser:Parser;
    public static function init(){
        interp = new Interp();
        parser = new Parser();
        loadVars(interp.variables);
    }
    static function loadVars(v:StringMap<Dynamic>){
        v.set("Math",Math);
        v.set("trace",Log.trace);
    }
    public static function evaluate(s:String) {
        var p = parser.parseString(s);
        if (p == null){return;}
        interp.execute(p);
    }
}