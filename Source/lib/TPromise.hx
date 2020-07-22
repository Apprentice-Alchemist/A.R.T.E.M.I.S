package lib;

class TPromise<T> {
    @:noCompletion var __resolves:Array<(T)->Void> = [];
    @:noCompletion var __rejections:Array<(Dynamic)->Void> = [];
    public function new<T>() {}
    public function resolve(data:T) for(o in __resolves) o(data);
    public function reject(err:Dynamic) for(o in __rejections) o(err);
    
    public function then(?onResolve:(T)->Void,?onReject:(Dynamic)->Void){
        if(onResolve != null) __resolves.push(onResolve);
        if(onReject != null) __rejections.push(onReject);
    }
}