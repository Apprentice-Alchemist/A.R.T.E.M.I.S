package;

import haxe.Exception;
import discordjs.Client;
import discordjs.Message;
import lib.JsonHandler;

class Bot {
	public static var bot:Client;
	public static var prefix:String = "]";
	public static var startTime:Date;

	public static function main() {
		lib.Logger.setTrace();
		start();
	}

	public static function start() {
		bot = new discordjs.Client();
		bot.on("ready", function(e) {
			bot.user.setPresence({
				status: ONLINE,
				activity: {
					type: WATCHING,
					name: "you."
				},
				afk: false,
			});
		});
		bot.on("message", function(m:Message) {
			try {
				if(m.author.bot){
					return;
				} else if(CommandHandler.handle(m)){
					return;
				} else {
					MessageHandler.handle(m);
				}
			} catch (err:Exception) {
				m.channel.send("BORK BORK BORK! AN ERROR HAS OCCURED! <@525025580106907659> \n" + err.message);
			}
		});
		bot.login(getToken()).then(function(e) {
			trace("Ready!");
			startTime = Date.now();
		}, function(e) {
			trace(e);
			haxe.Timer.delay(start, 5000);
		});
	}

	public static function onReady() {
		trace("Ready!");
		trace("Invite link : " + bot.generateInvite(["ADMINISTATOR"]));
	}
	
	static function getToken() {
		return JsonHandler.canRead("auth.json") ? JsonHandler.read("auth.json").token : Sys.getEnv("token").toString();
	}

	static function getModioKey() {
		return JsonHandler.canRead("auth.json") ? JsonHandler.read("auth.json").modio_key : Sys.getEnv("modio_key").toString();
	}
}
