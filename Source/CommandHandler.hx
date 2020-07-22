package;
import lib.EvalHandler;
import sys.io.File;
import discordjs.MessageEmbed.ColorResolvableData as Color;
import discordjs.*;
import commands.Command;
import commands.*;
using StringTools;

class CommandHandler {
	static var eval:EvalHandler = new EvalHandler();
	public static var bot:Client = Bot.bot;
	public static var has_init:Bool = false;
	public static var commands:Map<String, Command>;
	public static function addCommand(cname:String, cclass:Command) {
		cname = cname.toLowerCase();
		if (getCommands().exists(cname))
			throw "Command " + cname + " set twice";
		getCommands().set(cname, cclass);
	}
	public inline static function getCommands(){
		return commands == null ? (commands = new Map()) : commands;
	}
	public static function handle(m:discordjs.Message):Bool {
		if (m.content.substring(0, Bot.prefix.length) == Bot.prefix){
			var command = m.content.substring(Bot.prefix.length, m.content.indexOf(" ") > 0 ? m.content.indexOf(" ") : m.content.length);
			switch command
			{
				case "info":
					var embed = new MessageEmbed();
					embed.setTitle("Info").setColor(Color.BLUE);
					embed.addField("Host OS",Sys.systemName());
					embed.addField("Start Time",Bot.startTime.toString());
					m.channel.send(embed);
				case "help":
					var commands = getCommands();
					var b = new StringBuf();
					for (o in commands.keys()) {
						if(commands.get(o).hidden) continue;
						b.add("\n" + commands.get(o).name + " : " + commands.get(o).shorthelp);
					}
					var embed = new MessageEmbed();
					embed.setTitle("Available Commands :");
					embed.setColor(Color.BLUE);
					embed.setDescription(b.toString());
					m.channel.send(embed);
					return true;
				case "logs":
					m.channel.send({files: [{name: "logs.txt", attachment: js.node.buffer.Buffer.from(File.getContent("logs.txt"))}]});
					return true;
				case "eval": 
					doEval(m); 
					return true;
				default:
					for(o in getCommands()){
						if(command == o.name){
							o.call(m,bot);
							return true;
						}
					}
			}			
		}
		return false;
	}
	public static function doEval(m:Message){
		if (m.author.id != "525025580106907659") return m.reply("You are not allowed to use this command!");
		var content = m.cleanContent.substr(Bot.prefix.length + "eval ".length);
		var answer = eval.evaluate(content,["message"=>m]);
		return m.reply(new MessageEmbed().setDescription(answer));
	}

	public static function config(m:Message):Void{
		if (m.author.id != "525025580106907659"){
			m.reply("You are not allowed to use this command!");
			return;
		}
		var content = m.content.substr((Bot.prefix + "config ").length);
		var args = content.split(" ");
		trace(args.join("$"));
		var it = args.iterator();
		var switches = new Map<String,String>();
		
		while(it.hasNext()){
			var arg = it.next();
			trace('arg $arg');
			// args.remove(arg);
			if(arg.startsWith("--")){
				var val = it.next();
				trace('value $val');
				switches.set(arg.substr(2),val);
				continue;
			}
		}
		var isUser = switches.get("guild") != "true";
		if(isUser){

		}else if(!isUser){
			Settings.getGuild(m.guild.id).set(switches.get("option"),switches.get("value"));
			Settings.save();
		}
		m.reply('Settings Update ${switches.get("options")} ${switches.get("value")}');
	}
}