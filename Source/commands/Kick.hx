package commands;

import lib.UserService;
import discordjs.*;
import discordjs.Client as DiscordClient;

class Kick extends Command {
    override public function new(){
		this.name = "kick";
		this.shorthelp = "Kicks the mentioned user.";
		this.longhelp = 'Usage : `]kick user "reason"`';
        super();
    }
    override public function _call(m:Message,b:DiscordClient){
        m.guild.members.fetch(m.author.id).then(function(e){if(e.hasPermission("KICK_MEMBERS",{admin_override: true,owner_override: true})){
            m.guild.members.fetch(m.mentions.users.entries().next().value.value.id).then(function(e){
                if(e.kickable){
                    var reason = m.content.substr(m.content.indexOf(">"));
                    e.send("You were kicked from " + e.guild.name + " because : " + reason);
                    e.kick();
                }else{
                    m.reply("Failed to kick user!");
                }
            });
        }else {
            m.reply("You do not have the required permissions to kick users!");
        }});
       }
    }
