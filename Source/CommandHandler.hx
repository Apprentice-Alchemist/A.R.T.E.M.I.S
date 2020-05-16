package;
import sys.io.File;
import js.node.buffer.Buffer;
import discordjs.MessageEmbed.ColorResolvableData as Color;
import lib.Settings.Logger;
// import haxicord.DiscordClient;
// import haxicord.types.Message;
import discordjs.*;
import commands.Command;
import commands.*;

// @:build(bot.macro.CommandBuild.run('commands'))
class CommandHandler {
	public static var bot:Client;
	public static var has_init:Bool = false;	
	public static var commands:Map<String, Command> = new Map<String, Command>();

	public static function init(_bot) {
		has_init = true;
		bot = _bot;
		addCommand("kick",new Kick());
		addCommand("mod",new Mod());
	}

	public static function addCommand(cname:String, cclass) {
		if (!has_init) {
			init(Bot.bot);
		}
		cname = cname.toLowerCase();
		if (commands.exists(cname))
			throw "Command " + cname + " set twice";
		commands.set(cname, cclass);
	}
	public static function getCommands(){
		if (!has_init) {
			init(Bot.bot);
		}
		return commands;
	}
	public static function handle(m:discordjs.Message):Void {
		if (!has_init){
			init(Bot.bot);
		}	
		if (m.content.substring(0, Bot.prefix.length) == Bot.prefix){
			var command = m.content.substring(Bot.prefix.length, m.content.indexOf(" ") > 0 ? m.content.indexOf(" ") : m.content.length);
			switch command{
				case "help":
					var commands = getCommands();
					var b = new StringBuf();
					for (o in commands.keys()) {
						b.add("\n" + commands.get(o).name + " : " + commands.get(o).shortHelp());
					}
					var embed = new MessageEmbed();
					embed.setTitle("Available Commands :");
					embed.setColor(Color.BLUE);
					embed.setDescription(b.toString());
					m.channel.send(embed);
				case "logs":
					m.channel.send({files: [{name: "logs.txt", attachment: js.node.buffer.Buffer.from(File.read("logs.txt").readAll().toString())}]});
				default:
					for(o in getCommands()){
						if(command == o.name){
							o.call(m,bot);
							return;
						}
					}
			}			
		}
	}
	public static function eval(m:Message){
	}
	public static function parseArgs(m:Message,n:String){
		var tmp = m.content.substr(m.content.indexOf(" "));
		var args = tmp.split('" "');
		return args;
	}
}