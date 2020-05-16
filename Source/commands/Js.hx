package commands;

import discordjs.*;

class Js extends Command {
	override public function new() {
		this.name = "js";
		this.shorthelp = "Retrives the Aground.js from the fancyfish games website.";
		this.longhelp = 'Retrives the Aground.js from the fancyfish games website. Usage : `]js`';
		super();
	}

	override public function _call(m:Message, b:Client) {
        var req = new haxe.Http("https://fancyfishgames.com/Aground/play/Aground.js");
        req.onData = function(e){
			// m.reply("Do);
        }
        req.onStatus = function(e){
            trace("Status : " + e);
        }
        req.onError = function(e){
            trace("Error : " + e);
        }
        req.request();
	}
}