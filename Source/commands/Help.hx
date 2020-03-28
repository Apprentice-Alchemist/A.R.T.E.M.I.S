package commands;
import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;
class Help extends Command {
    static var c:CommandHandler;
    public function new(_c:CommandHandler){super(); c = _c;}

    override function call(m:Message, _bot:DiscordClient){
        
    }
}