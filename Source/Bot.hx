package;
import haxicord.utils.DPERMS;
import haxicord.types.Guild;
import haxicord.types.GuildMember;
import haxicord.DiscordClient;

class Bot {
	public static inline var VERSION:String = "0.0.1";
	public static var bot:DiscordClient;
	public static var prefix:String = "]";
	public static var startTime:Date;
	public static function main() {
		lib.EvalHandler.init();
		lib.Settings.Logger.setTrace();
		start();
				
	}
	public static function start(){
		bot = new DiscordClient(getToken());
		bot.onReady = onReady;
		bot.onMessage = MessageHandler.handle;
		bot.onGuildCreate = function(g) {}
		bot.onMemberJoin = onMemberJoin;
	}
	public static function onReady() {
		trace("Ready!"); 
		trace("Invite link : " + bot.getInviteLink(DPERMS.ADMINISTRATOR));
		Bot.bot.sendMessage("704748213655175300",{embed:{author: {name: "Artemis v" + VERSION,icon_url: Bot.bot.user.avatarUrl},description: "Artemis v" + VERSION + " initialised.",timestamp: Date.now(),}});
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