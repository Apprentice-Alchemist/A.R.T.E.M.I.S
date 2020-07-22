package commands;

import discordjs.*;

@:keep
interface Command {
	public final name:String;
	public final shorthelp:String;
	public final longhelp:String;
	public final hidden:Bool;
	public function call(m:Message,b:Client):Void;
}