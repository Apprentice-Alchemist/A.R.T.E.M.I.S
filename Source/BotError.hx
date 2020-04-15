package;

import com.raidandfade.haxicord.types.DMChannel;
import com.raidandfade.haxicord.types.User;

class BotError{
    public static var last_error:BotError;
    public static var error_map:Array<BotError> = [];
	public static var sendErrors = function() {
        var b = new StringBuf();
        for(o in error_map){
            b.add(o.error);
        }
        Bot.bot.sendMessage("639182974931435550",{content: b.toString()});
        b = null;
    }
    public var error:String;
    public function new(message:String,?critical:Bool = false){
        this.error = message;
        error_map.push(this);
        sendErrors();
    }
}