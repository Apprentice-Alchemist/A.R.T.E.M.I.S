package commands;

import discordjs.MessageEmbed.ColorResolvableData;
import haxe.Json;
import lib.Modio;
import discordjs.*;

class Mod extends Command {
    public var lastMessage:Message;
    public var channel:TextChannel;
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
                b.add(Reflect.field(data,Std.string(o)).name + "\n");
            };
			channel.send("There are multiple mods matching that input : \n" + b.toString());
		} else if (json.result_count == 1){
        var mod = Reflect.field(data,"0");
        var embed = new MessageEmbed();
        embed.setDescription(mod.summary);
        embed.setTitle(mod.name);
        embed.addField("Id",mod.id,true);
        embed.setColor(ColorResolvableData.BLUE);
		channel.send(embed);
        }else{
			trace("Mod not found : " + lastMessage.content.substr(lastMessage.content.indexOf(" ")));
			channel.send({content: "No such mod : " + lastMessage.content.substr(lastMessage.content.indexOf(" "))});
        }
        
    }
	override public function _call(m:Message, b:Client){
        channel = m.channel;
        Modio.makeRequest("https://api.mod.io/v1/games/34/mods?api_key=" + Bot.getModioKey() + "&_q=" + m.content.substr(m.content.indexOf(" ")),processMods);
    }
}