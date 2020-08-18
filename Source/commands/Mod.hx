package commands;

import discordjs.MessageEmbed.ColorResolvableData;
import haxe.Json;
import lib.Modio;
import discordjs.*;

@:keep
class Mod implements Command {
	public final name:String;
	public final shorthelp:String;
	public final longhelp:String;
	public final hidden = true;
	public var lastMessage:Message;

	public function new() {
		this.name = "mod";
		this.shorthelp = "Get a mod!";
		this.longhelp = "Returns a mod, usage : `]mod mod_name`";
	}

	public static function __init__() {
		CommandHandler.addCommand("mod", new Mod());
	}

	public function processMods(data:String, channel:TextChannel) {
		try {
			trace("Mods processed!");
			var json = Json.parse(data);
			var data = json.data;
			if (json.result_count > 1) {
				var b = new StringBuf();
				for (o in 0...json.result_count) {
					b.add(data[o].name + "\n");
				};
				channel.send("There are multiple mods matching that input : \n" + b.toString());
			} else if (json.result_count == 1) {
				var mod = data[0];
				var embed = new MessageEmbed();
				embed.setDescription(mod.summary);
				embed.setTitle(mod.name);
				embed.addField("Id", mod.id, true);
				embed.setColor(ColorResolvableData.BLUE);
				channel.send(embed);
			} else {
				trace("Mod not found : " + lastMessage.content.substr(lastMessage.content.indexOf(" ")));
				channel.send({content: "No such mod : " + lastMessage.content.substr(lastMessage.content.indexOf(" "))});
			}
		} catch (e) {
			channel.send(e.message);
		}
	}

	public function call(m:Message, b:Client) {
		try @:privateAccess {
			Modio.makeRequest("https://api.mod.io/v1/games/34/mods?api_key=" + Bot.getModioKey() + "&_q=" + m.content.substr(m.content.indexOf(" ")))
				.then(processMods.bind(_, m.channel), function(e) {
					m.reply("Modio error" + "\n" + e);
				});
		} catch (e)
			trace(e);
	}
}
