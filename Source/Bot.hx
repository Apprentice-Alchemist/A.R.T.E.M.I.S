package;
import services.Modio;
import haxe.Timer;
import com.raidandfade.haxicord.types.Guild;
import com.raidandfade.haxicord.types.GuildMember;
import com.raidandfade.haxicord.DiscordClient;

class Bot {
	public static var bot:DiscordClient;
	public static var prefix:String = "]";
	public static var startTime:Date;
	public static var handler:MessageHandler;
	public static var auth:Dynamic;
	public static function main() {
		startTime = Date.now();
		bot = new DiscordClient(getToken());
		bot.onReady = onReady;
		bot.onMessage = MessageHandler.handle;
		bot.onGuildCreate = function(g) {}
		bot.onMemberJoin = onMemberJoin;
		// bot.setStatus({status: "online"});
		Modio.init();
		onDelay();
		
	}	
	public static function onDelay(){
		trace(Modio.getMods());
		haxe.Timer.delay(onDelay,10000);
	}
	public function tick(){}
	public static function onReady() {
		trace("My invite link is: " + bot.getInviteLink());
		trace(Date.now().getTime() - startTime.getTime());
		BotError.sendErrors();
	}
	public static function onMemberJoin(g:Guild, m:GuildMember) {}
	public static function getToken(){
		if (lib.JsonHandler.canRead("auth.json")){
			return lib.JsonHandler.read("auth.json").token;
		} else {
			return Sys.getEnv("token").toString();
		}
	}
	public static function getModioKey() {
		if (lib.JsonHandler.canRead("auth.json")) {
			return lib.JsonHandler.read("auth.json").modio_key;
		} else {
			return Sys.getEnv("modio_key").toString();
		}
	}
}