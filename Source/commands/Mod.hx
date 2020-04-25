package commands;

import haxe.Json;
import lib.Modio;
import com.raidandfade.haxicord.types.Message;
import com.raidandfade.haxicord.DiscordClient;

class Mod extends Command {
    public var lastMessage:Message;
    override public function new(){
        super();
        this.name = "mod";
        this.shorthelp = "Get a mod!";
        this.longhelp = "Returns a mod, usage : `]mod mod_name`";
    }
    public function processMods(data:String){
        var json = Json.parse(data);
        var data = json.data;
        if(json.result_count > 1){
            var b = new StringBuf();
            for(o in 0...json.result_count){
                b.add(Reflect.field(data,"0").name + "\n");
            };
			lastMessage.reply({content: "There are multiple mods matching that input : \n" + b.toString()});
		} else if (json.result_count == 1){
        var mod = Reflect.field(data,"0");
        lastMessage.reply({embed:{title: mod.name,description: mod.summary,fields:[{name:"Id :",value: mod.id,_inline: true}]}});
        }else{
			trace("Mod not found : " + lastMessage.content.substr(lastMessage.content.indexOf(" ")));
			lastMessage.reply({content: "No such mod : " + lastMessage.content.substr(lastMessage.content.indexOf(" "))});
        }
        
    }
	override public function _call(m:Message, b:DiscordClient){
        lastMessage = m;
        Modio.makeRequest("https://api.mod.io/v1/games/34/mods?api_key=" + Bot.getModioKey() + "&_q=" + m.content.substr(m.content.indexOf(" ")),processMods);
    }
}