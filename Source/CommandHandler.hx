package;
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
		addCommand("help",new Help());
		// addCommand("eval", new Eval());
		addCommand("kick",new Kick());
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
			for (coms in commands.keys()) {
				if (m.content.substr(Bot.prefix.length, coms.length) == coms) {
					return commands.get(coms).call(m, bot);
				}			
			}
			return m.reply({content: "No command found : " + m.content.substr(Bot.prefix.length,m.content.indexOf(" "))});
		}	
	}
	public static function parseArgs(m:Message,n:String){
		var tmp = m.content.substr(n.length + Bot.prefix.length);
		var args = StringTools.htmlEscape(tmp,true).split('&quot');
		return args;
	}
}