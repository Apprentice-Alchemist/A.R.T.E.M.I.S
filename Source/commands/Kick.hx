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
        // var u = m.getMember();        
		// var kick = m.content.split(" ")[1].split("<@").join("").split(">").join("");
        // if(UserService.canKick(u)){
        //     try{
        //     m.getGuild().getMember(m.mentions[0].id.id,function(e){e.kick();});
        //     Bot.bot.getUser(kick,function(e){m.reply({content: "User kicked : " + e.username});});
        //     }catch(e:Dynamic){m.reply({content: "An error occured while kicking : " + Std.string(e)});}
        // }else{
        //     m.reply({content: "You do not have the required permissions to kick that user!"});
        // }
        m.guild.members.fetch(m.author.id).then(function(e){if(e.hasPermission("KICK_MEMBERS",{})){
            m.guild.members.fetch(m.mentions.users.iterator().next().id).then(function(e){
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
