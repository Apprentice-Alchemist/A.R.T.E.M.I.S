package commands;

import discordjs.*;

@:keep
class Ghost implements Command {
	public final name = "ghost";
	public final shorthelp = "Reposts the message, and deletes the orignal one";
	public final longhelp = "Reposts the message, and deletes the orignal one.";
	public final hidden = false;
	public function new() {}
	public static function __init__() {
		CommandHandler.addCommand("ghost",new Ghost());
	}
	public function call(m:Message, b:Client) {
        var content = m.content;
        trace(content);
		var msg = content.substring((Bot.prefix + "ghost ").length,content.length);
		m.delete();
        m.channel.send(msg).catchError(function(err){});
	}
}