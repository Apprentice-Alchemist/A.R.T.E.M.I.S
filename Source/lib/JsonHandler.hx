package lib;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;

class JsonHandler {
    public static inline function canRead(file:String){
        return FileSystem.exists(file);
    }
	/**
		Read the content of the file and returns it's Json version.
        @param file -the path to the file
	**/
    public static function read(file:String):Null<Dynamic>{
        var content:Null<Dynamic> = null;
      if (canRead(file)){
          try{
			content = sys.io.File.getContent(file);
          }catch(e:Dynamic){
              trace(e);
          }
      }
		return Json.parse(content);
		
    }
	/**
        Return true if the file exists and the file saving was succesful.
        @param file -the path to the file
        @param s -the json you want to write
	**/
    public static function write(file:String,s:Dynamic){      
        if(!canRead(file)){return;}
        try{
            var a = sys.io.File.write(file);
            a.writeString(Json.stringify(s));
            a.close();
        }catch(e:Dynamic){
            trace(e);
        }
    }
}