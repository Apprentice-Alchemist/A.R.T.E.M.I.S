package lib;

import sys.FileSystem;
import haxe.macro.Context;

using StringTools;
using haxe.macro.Tools;

class Macro {
    #if macro
    public static function include(){
        for(o in FileSystem.readDirectory("Source/commands")){
            if(o.endsWith(".hx")){
				var type = Context.getType("commands." + new haxe.io.Path(o).file);				
            }
        }
    }
    #end
}