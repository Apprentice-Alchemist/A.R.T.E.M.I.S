package;
import lib.EvalHandler;
import haxe.Log;
import com.raidandfade.haxicord.endpoints.Typedefs.GetGuildFilter;
import com.raidandfade.haxicord.endpoints.Endpoints;
import js.node.net.Socket;
import com.raidandfade.haxicord.utils.DPERMS;
import lib.Modio;
import haxe.Timer;
import com.raidandfade.haxicord.types.Guild;
import com.raidandfade.haxicord.types.GuildMember;
import com.raidandfade.haxicord.DiscordClient;

class Bot {
	public static var hasStartedBefore:Bool = false;
	public static var bot:DiscordClient;
	public static var prefix:String = "]";
	public static var startTime:Date;
	public static function main() {
		if(!hasStartedBefore){
		hasStartedBefore = true;
		EvalHandler.init();
		lib.Settings.Logger.logs = lib.Settings.Logger.getLogData();
		lib.Settings.Logger.setTrace();
		}
		try{
		bot = new DiscordClient(getToken());
		bot.onReady = onReady;
		bot.onMessage = MessageHandler.handle;
		bot.onGuildCreate = function(g) {}
		bot.onMemberJoin = onMemberJoin;
		}catch(e:Dynamic){trace("Fatal Error : " + e); Bot.main();}
		
	}	
	public static function onDelay(){haxe.Timer.delay(onDelay,10000);}
	public static function onReady() {trace("Ready!"); trace("Invite link : " + bot.getInviteLink(DPERMS.ADMINISTRATOR));}
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