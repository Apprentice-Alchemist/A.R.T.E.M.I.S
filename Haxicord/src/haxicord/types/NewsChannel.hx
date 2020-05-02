package haxicord.types;

class NewsChannel extends TextChannel{
    @:dox(hide)
    public function new(_chan:haxicord.types.structs.GuildChannel.NewsChannel, _client:DiscordClient) {
        super(_chan,_client);
    }
    
    @:dox(hide)
    public static function fromStruct(_chan, _client) {
        return new NewsChannel(_chan, _client);
    }
}
