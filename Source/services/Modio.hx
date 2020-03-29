package services;

class Modio {
	static var game_id:Int = 34;
    static var apikey:String;
    public static function init(){
        apikey = Bot.getModioKey();
    }
    public static function getModComments(){
        var key = apikey;
    }
}