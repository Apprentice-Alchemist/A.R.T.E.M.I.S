package;

import discordjs.MessageEmbed;
import discordjs.TextChannel;
import haxe.Exception;
import discordjs.Client;
import lib.JsonHandler;
import lib.Settings.Logger;

import lib.EvalHandler;

class Bot {
	public static inline var VERSION:String = "0.0.1";
	public static var bot:Client;
	public static var prefix:String = "]";
	public static var startTime:Date;
	public static function main() {
		try{
		haxe.MainLoop.add(tock);
		__init();
		}catch(e:Exception){
			trace("Possibly Fatal Error. " + e.details());
		}				
	}
	@:noCompletion
	private static function __init(){
		try{
			EvalHandler.init();
		}catch(e:Exception){
			trace("Error in evalhandler. " + e.details());
		}
		try {
			Logger.setTrace();
		} catch (e) {
			trace("Error in logger. " + e.details());
		}
		try {
			start();
		} catch (e:Exception) {
			trace("Error in start. " + e.details());
		}
	}
	public static function tock(){}
	public static function start(){
		bot = new discordjs.Client();
		bot.on("ready",function(e){
			var ch:js.lib.Promise<TextChannel> = (cast bot.channels.fetch("704748213655175300", false)).then(function(e) {
				var embed = new MessageEmbed();
				embed.setAuthor("Artemis v" + VERSION,bot.user.defaultAvatarURL);
				embed.setColor(ColorResolvableData.BLUE);
				embed.setTimestamp(Date.now());
				embed.setDescription("Artemis Initialized.");
				e.send(embed);
			});
		});
		bot.on("message",CommandHandler.handle);
		bot.login(getToken()).then(function(e){trace("Ready!");});
		
	}
	public static function onReady() {
		trace("Ready!"); 
		trace("Invite link : " + bot.generateInvite(["ADMINISTATOR"]));
	}
	public static function getToken(){
		return JsonHandler.canRead("auth.json") ? JsonHandler.read("auth.json").token : Sys.getEnv("token").toString();
	}
	public static function getModioKey() {
		return JsonHandler.canRead("auth.json") ? JsonHandler.read("auth.json").modio_key : Sys.getEnv("modio_key").toString();
	}
}