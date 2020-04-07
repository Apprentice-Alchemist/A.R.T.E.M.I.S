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
            return;
        } else {
            // handleMessage(m);
            return;
        }
        
    }
    public static function handleMessage(m:Message):Dynamic{
        var content = m.content;
        if(StringTools.contains(content.toLowerCase(),"good bot")){
            m.reply({content: "Thanks, I do my best!"});
            trace("message handled");
            return true;
		} else if (StringTools.contains(content.toLowerCase(), "bad bot")){
            m.reply({content: "Sorry, I'll do better next time."});
            trace("message handled");
			return true;
        } else if(m.mentions.lastIndexOf(Bot.bot.user) != null){
            m.reply({content: "Hello, did you call me? If you want to know what I can do type `]help`!"});
            return true;
        }
        trace("message handled");
		return false;
    }
}