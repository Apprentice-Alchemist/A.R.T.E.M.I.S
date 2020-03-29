package;

import sys.io.FileInput;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

class JsonHandler {
    public static function canRead(file:String){
        return FileSystem.exists(file);
    }
    public static function read(file:String):Null<Dynamic>{
      if (canRead(file)){
          try{
			var content = Json.parse(File.getContent(file));
            return content;
          }catch(e:Dynamic){
              trace(e);
              return null;
          }
      } else{
          return null;
      }
		
    }
	/**
        Return true if the file exists and the file saving was succesful.
	**/
    public static function write(file:String,s:Dynamic):Bool{
        var content = Json.stringify(s);
        if(!FileSystem.exists(file)){
            return false;
        }
        try{
            File.saveContent(file,content);
        }catch(e:Dynamic){
            trace(e);
            return false;
        }
        return true;
    }
}