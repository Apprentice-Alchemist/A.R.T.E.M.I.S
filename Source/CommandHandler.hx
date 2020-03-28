package;
import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;
import commands.Command;
import commands.*;

class CommandHandler {
	var bot:DiscordClient;

	var commands:Map<String, Command> = new Map<String, Command>();

	public function new(_bot) {
		bot = _bot;
		addCommand("help", new Help(this));
	}

	private function addCommand(cname:String, cclass) {
		cname = cname.toLowerCase();
		if (commands.exists(cname))
			throw "Command " + cname + " set twice";
		commands.set(cname, cclass);
	}

	public function handle(m:Message) {
		if (m.content.substring(0, Bot.prefix.length) == Bot.prefix) {
			for (coms in commands.keys()) {
				if (m.content.substr(Bot.prefix.length, coms.length) == coms) {
					commands.get(coms).call(m, bot);
				}
			}
		}
	}
}