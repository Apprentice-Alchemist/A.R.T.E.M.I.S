package services;

import com.raidandfade.haxicord.types.GuildMember;
import com.raidandfade.haxicord.utils.DPERMS;

class UserService {
    public static function getPerms(u:GuildMember,s:String):Bool{
        var perm = Reflect.field(DPERMS,s);
        if(u.hasPermissions(perm)){
            return true;
        }else{
            return false;
        }
    }
    public static function canKick(u:GuildMember){
        var tmp = u.hasPermissions(DPERMS.ADMINISTRATOR) || u.hasPermissions(DPERMS.KICK_MEMBERS);
        return tmp;
    }
    public static function canBan(u:GuildMember){
		var tmp = u.hasPermissions(DPERMS.ADMINISTRATOR) || u.hasPermissions(DPERMS.BAN_MEMBERS);
		return tmp;
    }
}