package commands;
import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;
class Help extends Command {
    public var name = "Help";
    override public function new(){
        this.shorthelp = "shorthelp";
        this.longhelp = "longhelp";
        super();
    }

    public function _call(m:Message, _bot:DiscordClient){
        var commands = CommandHandler.getCommands();
        var stringBuf = new StringBuf();
        for (o in commands.keys()){
            stringBuf.add("\n"+ o + " : " + commands.get(o).shortHelp());
        }
        m.reply({embed: {title: "Available Commands",description: stringBuf.toString()}});
    }
}