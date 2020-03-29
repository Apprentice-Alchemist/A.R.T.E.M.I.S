package commands;

import services.UserService;
import com.raidandfade.haxicord.types.Message;
import com.raidandfade.haxicord.DiscordClient;

class Kick extends Command {
    override public function new(){
        this.name = "kick";
        this.shorthelp = "Kicks the mentioned user.";
        this.longhelp = 'Usage : `]kick user "reason"`';
        super();
    }
    override public function _call(m:Message,b:DiscordClient){
        var u = m.getMember();        
		var args = CommandHandler.parseArgs(m, this.name);
        if(UserService.canKick(u)){
        //    UserService.getGuildMember(m,args[1]);
        };
    }
}