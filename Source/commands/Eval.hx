package commands;
import services.EvalHandler;
import com.raidandfade.haxicord.types.Message;
import com.raidandfade.haxicord.DiscordClient;

class Eval extends Command{
    public override function new(){
		this.name = "eval";
		this.shorthelp = "Eval!";
		this.longhelp = 'Evaluates a command.';
		super(); 
    }
    public override function _call(m:Message,b:DiscordClient){
        var tmp = m.content.substr(Bot.prefix.length + "eval".length);
        // m.reply({content: "```haxe\n" + EvalHander.evaluate(tmp)) + "\n```"});
    }
}