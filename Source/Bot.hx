package;

import com.raidandfade.haxicord.websocket.WebSocketConnection;
import haxe.Json;
import haxe.Timer;
import com.raidandfade.haxicord.types.Guild;
import com.raidandfade.haxicord.types.GuildMember;
import com.raidandfade.haxicord.types.Message;
import com.raidandfade.haxicord.types.Snowflake;
import com.raidandfade.haxicord.DiscordClient;
import com.raidandfade.haxicord.shardmaster.Sharder;
import MessageHandler;
import CommandHandler;

class Bot {
	static var sharder:Sharder;
	static var bot:DiscordClient;
	public static var prefix:String = "]";
	static var startTime:Date;
	static var handler:MessageHandler;
	static function main() {

		startTime = Date.now();
		bot = new DiscordClient(Sys.getEnv("DevBotToken"));
		handler = new MessageHandler(bot);
		trace(Sys.getEnv("DevBotToken"));
		bot.onReady = onReady;
		bot.onMessage = onMessage;
		bot.onGuildCreate = function(g) {
			trace("Guild Object Created For " + g.name + "(" + g.id.id + ")");
		}
		bot.onMemberJoin = onMemberJoin;
	}

	// public function handle(m:Message) {
	// 	doStuffWith(m);
	// }

	public static function onMessage(m:Message) {
		handler.handle(m);	
	}	

	public static function onReady() {
		// trace("My invite link is: " + discordBot.getInviteLink());
		trace(Date.now().getTime() - startTime.getTime());
	}

	public static function onMemberJoin(g:Guild, m:GuildMember) {}
}