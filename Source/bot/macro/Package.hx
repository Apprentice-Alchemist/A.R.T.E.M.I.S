package bot.macro;

import sys.FileSystem;
#if macro
import haxe.macro.*;
#end
class Package {
    #if macro
    public function generate(path:String = "package.json"){
        // Context.onGenerate(function(_){
        //     var package:Package = {
        //         name: "Artemis",
        //         description: "N/A",
        //         dependencies: {pako: "1.0.11",ws: "7.2.3"},
        //         engines:{node: "12.x"},
        //         version: Bot.VERSION,
        //         scripts: {}
        //     }
        // File.write(path).writeString(Json.stringify(package));
        // });
    }
    #end
}
typedef Package = {
    var name:String;
    var description:String;
    @:optional var dependencies;
    @:optional var devDependencies;
    @:optional var engines;    
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