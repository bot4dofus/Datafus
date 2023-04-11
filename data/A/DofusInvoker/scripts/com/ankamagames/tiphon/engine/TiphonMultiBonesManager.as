package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getQualifiedClassName;
   
   public final class TiphonMultiBonesManager
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonMultiBonesManager));
      
      private static var _instance:TiphonMultiBonesManager;
       
      
      private var _nbBonesToLoad:int;
      
      private var _nbBonesLoaded:int;
      
      public function TiphonMultiBonesManager()
      {
         super();
      }
      
      public static function getInstance() : TiphonMultiBonesManager
      {
         if(!_instance)
         {
            _instance = new TiphonMultiBonesManager();
         }
         return _instance;
      }
      
      public function getAllBonesFromLook(look:TiphonEntityLook, result:Array = null) : Array
      {
         var seTab:* = undefined;
         var se:* = undefined;
         if(!result)
         {
            result = new Array();
         }
         result.push(look.getBone());
         for each(seTab in look.getSubEntities())
         {
            for each(se in seTab)
            {
               this.getAllBonesFromLook(se,result);
            }
         }
         return result;
      }
      
      public function onLoadedBone(bone:uint, callback:Callback = null) : void
      {
         ++this._nbBonesLoaded;
         if(this._nbBonesLoaded == this._nbBonesToLoad)
         {
            if(callback != null)
            {
               callback.exec();
            }
         }
      }
      
      public function forceBonesLoading(bones:Array, callback:Callback = null) : void
      {
         var bone:uint = 0;
         var hasBone:Boolean = false;
         var hasResource:* = false;
         var file:Uri = null;
         this._nbBonesLoaded = 0;
         this._nbBonesToLoad = bones.length;
         for each(bone in bones)
         {
            hasBone = BoneIndexManager.getInstance().hasCustomBone(bone);
            hasResource = Tiphon.skullLibrary.getResourceById(bone) != null;
            if(hasBone || hasResource)
            {
               this.onLoadedBone(bone,callback);
            }
            else
            {
               file = new Uri(TiphonConstants.SWF_SKULL_PATH + bone + ".swl");
               Tiphon.skullLibrary.addResource(bone,file);
               Tiphon.skullLibrary.askResource(bone,null,new Callback(this.onLoadedBone,bone,callback));
            }
         }
      }
   }
}
