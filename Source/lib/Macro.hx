package lib;

import haxe.macro.Type;
import sys.FileSystem;
import haxe.macro.Compiler;
import haxe.macro.Context;
using StringTools;
class Macro {
    #if macro
    public static function include(){
        for(o in FileSystem.readDirectory("Source/commands")){
            if(o.endsWith(".hx")){
                trace(new haxe.io.Path(o).file);
				Context.getType("commands." + new haxe.io.Path(o).file);
            }
        }
    }
    #end
}