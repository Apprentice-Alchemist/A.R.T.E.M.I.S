package bot.macro;

import haxe.Exception;
import sys.FileSystem;

import haxe.macro.*;

class Package {
    public static function generate(path:String){
        try{
        Context.onAfterGenerate(function(){
            
        });
    }catch(e:Exception){trace(e.message + e.stack);}
    }    
}
typedef PackageFile = {
    var name:String;
    var description:String;
    @:optional var dependencies:Map<String,String>;
	@:optional var devDependenciesMap: Map<String,String>;
	@:optional var engines:Map<String, String>;    
}
// {
// 	"name": "Artemis",
// 	"description": "A discord bot",
// 	"dependencies": {"pako": "1.0.11", "ws": "7.2.3"},
// 	"engines": {"node": "12.x"},
// 	"devDependencies": {"nodemon": "2.0.2"},
// 	"version": "0.0.1",
// 	"scripts": {"start": "nodemon node/bot.js --ignore '*.json'"}
// }