package;

import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.types.Message;

class MessageHandler {
    var bot:DiscordClient;
    var commandHandler:CommandHandler;
    public function new(_bot:DiscordClient){bot = _bot; commandHandler = new CommandHandler(bot);}

    public function handle(m:Message){
		if(m.content.substring(0, Bot.prefix.length) == Bot.prefix){
            commandHandler.handle(m);
        } else {
            handleMessage();
        }
        
    }
    public function handleMessage(){ trace('message handled');}
}