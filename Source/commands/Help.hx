package commands;
import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;
class Help extends Command {
    override public function new(){
        this.name ="Help";
        this.shorthelp = "shorthelp";
        this.longhelp = "longhelp";
        super();
    }

    public override function _call(m:Message, _bot:DiscordClient){
        var commands = CommandHandler.getCommands();
        var stringBuf = new StringBuf();
        for (o in commands.keys()){
            if (commands.get(o).name == "Help") continue;
			stringBuf.add("\n" + commands.get(o).name + " : " + commands.get(o).shortHelp());
        }
        m.reply({embed: {title: "Available Commands",description: stringBuf.toString()}});
        trace("Help Given");
    }
}