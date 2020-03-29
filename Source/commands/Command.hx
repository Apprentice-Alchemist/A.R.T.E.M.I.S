package commands;

import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;

class Command {
	public function new(){

	}
	public var shorthelp:String;
	public var longhelp:String;
	public function shortHelp(){
		return shorthelp;
	}
	public function longHelp(){
		return longhelp;
	}
	public dynamic function call(_msg:Message, _bot:DiscordClient) {
		_call(_msg,_bot);
		trace("Command used : " + this.name);
	}
}