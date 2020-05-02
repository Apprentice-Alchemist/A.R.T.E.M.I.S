package commands;

import haxicord.DiscordClient;
import haxicord.types.Message;

class Command {
	public function new(){}
	public var name:String;
	public var shorthelp:String;
	public var longhelp:String;
	public function shortHelp(){
		return shorthelp;
	}
	public function longHelp(){
		return longhelp;
	}
	public function _call(m:Message,b:DiscordClient){}
	public dynamic function call(_msg:Message, _bot:DiscordClient) {
		_call(_msg,_bot);
		trace("Command " + this.name + " used by : " + _msg.author.username);
	}
}