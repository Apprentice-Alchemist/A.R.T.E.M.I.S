package;

import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;

class MessageHandler {
    var bot:DiscordClient;
    public function new(_bot:DiscordClient){
        bot = _bot;
    }

    public static function handle(m:Message){
		if(m.content.substring(0, Bot.prefix.length) == Bot.prefix){
            CommandHandler.handle(m);
        } else {
            handleMessage(m);
        }
        
    }
    public static function handleMessage(m:Message){
        var content = m.content;
        if(StringTools.contains(content.toLowerCase(),"good bot")){
            m.reply({content: "Thanks, I do my best!"});
		} else if (StringTools.contains(content.toLowerCase(), "bad bot")){
            m.reply({content: "Sorry, I'll do better next time."});
        }
    }
}