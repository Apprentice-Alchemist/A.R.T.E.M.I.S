package;

import discordjs.Message;
using StringTools;
class MessageHandler {
    public static function handle(m:Message){
        var content = m.content.toLowerCase();
        if(content.contains("good bot")){
            m.channel.send("Thanks, I do my best!");
            return;
        }else {
            return;
        }
    }
}