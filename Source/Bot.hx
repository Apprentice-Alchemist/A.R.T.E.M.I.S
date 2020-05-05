package;
import lib.JsonHandler;
import lib.Settings.Logger;
import haxe.Json;
import lib.EvalHandler;
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
		try{
		haxe.MainLoop.add(tock);
		__init();
		}catch(e:Dynamic){
			trace("Possibly Fatal Error. " + e + haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
		}				
	}
	@:noCompletion
	private static function __init(){
		try{
			EvalHandler.init();
		}catch(e:Dynamic){
			trace("Error in evalhandler. " + e + haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
		}
		try {		
			Logger.logs = Logger.getLogData();
			Logger.setTrace();
		} catch (e:Dynamic) {
			trace("Error in logger. " + e + haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
		}
		try {
			start();
		} catch (e:Dynamic) {
			trace("Error in start. " + e + haxe.CallStack.toString(haxe.CallStack.exceptionStack()));
		}
	}
	public static function tock(){}
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