package haxicord.cachehandler;

import haxicord.types.Message;
import haxicord.types.User;
import haxicord.logger.Logger;
import haxicord.types.Channel;
import haxicord.types.DMChannel;
import haxicord.types.GuildChannel;
import haxicord.types.GuildMember;
import haxicord.types.TextChannel;
import haxicord.types.CategoryChannel;
import haxicord.types.VoiceChannel;
import haxicord.types.Guild;
import haxicord.types.Role;
import haxicord.types.Snowflake;

interface DataCache{
    public function setMessage(id:String,m:Message):Void;
    public function setUser(id:String,u:User):Void;
    public function setChannel(id:String,ch:Channel):Void;
    public function setDMChannel(id:String,dmch:DMChannel):Void;
    public function setGuild(id:String,g:Guild):Void;
    public function setUserDMChannel(id:String,dmchid:String):Void;
    
    public function delMessage(id:String):Void;
    public function delUser(id:String):Void;
    public function delChannel(id:String):Void;
    public function delDMChannel(id:String):Void;
    public function delGuild(id:String):Void;
    public function delUserDMChannel(id:String):Void;
    
    public function getMessage(id:String):Null<Message>;
    public function getUser(id:String):Null<User>;
    public function getChannel(id:String):Null<Channel>;
    public function getDMChannel(id:String):Null<DMChannel>;
    public function getGuild(id:String):Null<Guild>;
    public function getUserDMChannel(id:String):Null<String>;

    public function getAllDMChannels():Array<DMChannel>;
    public function getAllGuilds():Array<Guild>;
}