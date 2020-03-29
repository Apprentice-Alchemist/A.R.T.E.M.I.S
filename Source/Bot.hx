package;

import haxe.Timer;
import com.raidandfade.haxicord.types.Guild;
import com.raidandfade.haxicord.types.GuildMember;
import com.raidandfade.haxicord.types.Message;
import com.raidandfade.haxicord.DiscordClient;
import MessageHandler;
import CommandHandler;

class Bot {
	public static var bot:DiscordClient;
	public static var prefix:String = "]";
	public static var startTime:Date;
	public static var handler:MessageHandler;
	public static var auth:Dynamic;
	public static function main() {
		startTime = Date.now();
		bot = new DiscordClient(getToken());
		trace(getToken() != null);
		bot.onReady = onReady;
		bot.onMessage = MessageHandler.handle;
		bot.onGuildCreate = function(g) {
			trace("Guild Object Created For " + g.name + "(" + g.id.id + ")");
		}
		bot.onMemberJoin = onMemberJoin;
		services.Modio.init();
		haxe.Timer.delay(onDelay, 10000);
	}	
	public static function onDelay(){

		haxe.Timer.delay(onDelay,10000);
	}
	public static function onReady() {
		trace("My invite link is: " + bot.getInviteLink());
		trace(Date.now().getTime() - startTime.getTime());
	}

	public static function onMemberJoin(g:Guild, m:GuildMember) {}
	public static function getToken(){
		if (JsonHandler.canRead("auth.json")){
			return JsonHandler.read("auth.json").token;
		} else {
			return Sys.getEnv("token").toString();
		}
	}
	public static function getModioKey() {
		if (JsonHandler.canRead("auth.json")) {
			return JsonHandler.read("auth.json").modio_key;
		} else {
			return Sys.getEnv("modio_key").toString();
		}
	}
}