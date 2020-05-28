package;

import haxe.Exception;
import discordjs.MessageEmbed;
import discordjs.TextChannel;
import discordjs.Client;
import lib.JsonHandler;
import lib.Settings.Logger;

class Bot {
	public static inline var VERSION:String = "0.0.1";
	public static var bot:Client;
	public static var prefix:String = "]";
	public static var startTime:Date;

	public static function main() {
		Logger.setTrace();
		start();
	}

	public static function start() {
		bot = new discordjs.Client();
		bot.once("ready", function(e) {
			var ch:js.lib.Promise<TextChannel> = (cast bot.channels.fetch("704748213655175300", false)).then(function(e) {
				var embed = new MessageEmbed();
				embed.setAuthor("Artemis v" + VERSION, bot.user.defaultAvatarURL);
				embed.setColor(ColorResolvableData.BLUE);
				embed.setTimestamp(Date.now());
				embed.setDescription("Artemis Initialized.");
				e.send(embed);
			});
		});
		bot.on("message", function(m) {
			try {
				CommandHandler.handle(m);
			} catch (e:Exception) {
				m.channel.send("An error occured while executing this command! \n" + "Logs : \n" + e.details().substr(0, 1000));
			}
		});
		bot.login(getToken()).then(function(e) {
			trace("Ready!");
		}, function(e) {
			trace(e);
			haxe.Timer.delay(start, 5000);
		});
	}

	public static function onReady() {
		trace("Ready!");
		trace("Invite link : " + bot.generateInvite(["ADMINISTATOR"]));
	}

	public static function getToken() {
		return JsonHandler.canRead("auth.json") ? JsonHandler.read("auth.json").token : Sys.getEnv("token").toString();
	}

	public static function getModioKey() {
		return JsonHandler.canRead("auth.json") ? JsonHandler.read("auth.json").modio_key : Sys.getEnv("modio_key").toString();
	}
}
