package lib;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;

class JsonHandler {

    public static inline function canRead(file:String){
        return FileSystem.exists(file);
    }
	/**
		Reads the contents of the file and returns an anonymous object.
        @param file -the path to the file
	**/
    public static function read(file:String):Dynamic{
        var content = "";
      if(canRead(file)){
          try{
            var tmp = File.read(file);
            content = tmp.readAll().toString();
          }catch(e:Dynamic){
              trace(e);
          }
      }
      return (content != null || content != "") ? Json.parse(content) : {};
    }
	/**
        Write json content to a file.
        @param file -the path to the file
        @param s -the json you want to write
	**/
    public static function write(file:String,s:Dynamic){      
            var a = sys.io.File.write(file);
            a.writeString(Json.stringify(s));
            a.close();
    }
}