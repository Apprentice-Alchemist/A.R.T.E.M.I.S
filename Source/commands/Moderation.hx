package commands;

import lib.UserService;
import discordjs.*;
import discordjs.Client as DiscordClient;

using StringTools;

@:keep
class Moderation implements Command {
	public final name = "kick";
	public final shorthelp = "Kicks the mentioned user.";
	public final longhelp = "Kicks the mentioned user";
	public final hidden = true;

	static function __init__() {
		CommandHandler.addCommand("kick", new Moderation(kick));
		CommandHandler.addCommand("ban", new Moderation(ban));
		CommandHandler.addCommand("warn", new Moderation(warn));
		CommandHandler.addCommand("mute", new Moderation(mute));
		CommandHandler.addCommand("purge", new Moderation(purge));
	}

	public final type:ModerationType;

	public function new(type:ModerationType) {
		this.name = cast type;
		this.type = type;
		shorthelp = longhelp = switch type {
			case ban: "Bans the mentioned user";
			case mute: "Mutes the mentioned user";
			case purge: "Purges a bunch of messages";
			case softban: "Softbans the user";
			case warn: "Warns the user";
			default: shorthelp;
		}
	}

	public function call(m:Message, b:DiscordClient) {
		switch type {
			case kick:
				kick(m, b);
			case ban:
				ban(m, b);
			case warn:
				warn(m, b);
			case mute:
				mute(m, b);
			case softban:
				return;
			case purge:
				m.channel.bulkDelete(Std.parseInt(m.content.substr((Bot.prefix + "purge ").length).ltrim().rtrim()), false).catchError(function(e) {
					Bot.bork(e,m.channel);
				});
		}
	}

	public function kick(m:Message, b:DiscordClient) {
		m.guild.members.fetch(m.author.id).then(function(e) {
			if (e.hasPermission("KICK_MEMBERS", {admin_override: true, owner_override: true})) {
				m.guild.members.fetch(m.mentions.users.entries().next().value.value.id).then(function(e:GuildMember) {
					if (e.kickable) {
						var reason = m.content.substr(m.content.indexOf(">"));
						e.send("You were kicked from " + e.guild.name + " because : " + reason).catchError(function(e) {
							trace(e);
						});
						m.channel.send(e.name + " was kicked because :" + reason);
						e.kick(reason);
					} else {
						m.reply("Failed to kick user!");
					}
				});
			} else {
				m.reply("You do not have the required permissions to kick users!");
			}
		});
	}

	public function ban(m:Message, b:DiscordClient) {
		m.guild.members.fetch(m.author.id).then(function(e:GuildMember) {
			if (e.hasPermission("BAN_MEMBERS", {admin_override: true, owner_override: true})) {
				m.guild.members.fetch(m.mentions.users.entries().next().value.value.id).then(function(e:GuildMember) {
					if (e.bannable) {
						var reason = m.content.substr(m.content.indexOf(">") + 2);
						e.send("You were banned from " + e.guild.name + " because : " + reason).catchError(function(e) {
							trace(e);
						});
						m.channel.send(e.name + " was banned because :" + reason);
						e.ban(reason);
					} else {
						m.reply("Failed to ban user!");
					}
				});
			} else {
				m.reply("You do not have the required permissions to ban users!");
			}
		});
	}

	public function warn(m:Message, b:DiscordClient) {
		m.reply("Not Implemented");
	}

	public function mute(m:Message, b:DiscordClient) {
		m.reply("Not implemented.");
	}
}

enum abstract ModerationType(String) {
	var kick = "kick";
	var ban = "ban";
	var warn = "warn";
	var mute = "mute";
	var softban = "softban";
	var purge = "purge";
}
