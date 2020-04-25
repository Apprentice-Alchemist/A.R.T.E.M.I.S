package;
import js.lib.webassembly.Module;
import haxe.ds.EnumValueMap;
import com.raidandfade.haxicord.endpoints.Endpoints.ErrorReport;
import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;
import commands.Command;
import commands.*;

class CommandHandler {
	public static var bot:DiscordClient;
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
	public static function handle(m:Message) {
		if (!has_init){
			init(Bot.bot);
		}
	
		if (m.content.substring(0, Bot.prefix.length) == Bot.prefix) {
			var command = m.content.substring(Bot.prefix.length,m.content.indexOf(" ") > 0 ? m.content.indexOf(" ") : m.content.length);
			trace(command);
			switch command {
				case "help":
					var commands = CommandHandler.getCommands();
					var stringBuf = new StringBuf();
					for (o in commands.keys()) {
						if (commands.get(o).name == "help")
							continue;
						stringBuf.add("\n" + commands.get(o).name + " : " + commands.get(o).shortHelp());
					}
					m.reply({embed: {title: "Available Commands", description: stringBuf.toString()}});
				case "eval": 
					return m.reply({content: "Not implemented yet!"});
				case "logs":
					m.reply({content: "Start logs."});
					for(o in Settings.formatLogs()){
						m.reply({content: o});
					}
					return m.reply({content: "End logs."});
				default:
					return commands.exists(command) ? commands.get(command).call(m, Bot.bot) : m.reply({content: "No command found : " + command});
			}
		}	
	}
	public static function parseArgs(m:Message,n:String){
		var tmp = m.content.substr(m.content.indexOf(" "));
		var args = tmp.split('" "');
		return args;
	}
}