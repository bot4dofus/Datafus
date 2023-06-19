package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class GameDataUpdater extends DataUpdateManager
   {
      
      private static var _self:GameDataUpdater;
       
      
      public function GameDataUpdater()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : GameDataUpdater
      {
         if(!_self)
         {
            _self = new GameDataUpdater();
         }
         return _self;
      }
      
      override protected function checkFileVersion(sFileName:String, sVersion:String) : Boolean
      {
         return false;
      }
      
      override public function clear() : void
      {
         GameDataFileAccessor.getInstance().close();
      }
      
      override protected function onLoaded(e:ResourceLoadedEvent) : void
      {
         switch(e.uri.fileType)
         {
            case "d2o":
            case "d2os":
               GameDataFileAccessor.getInstance().init(e.uri);
               if(_versions[e.uri.tag.file] != e.uri.tag.version)
               {
                  _versions[e.uri.tag.file] = e.uri.tag.version;
                  StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_FILES_INFO,_storeKey,_versions);
               }
               dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE,false,false,e.uri.tag.file));
               _dataFilesLoaded = true;
               ++_loadedFileCount;
               break;
            default:
               super.onLoaded(e);
         }
      }
   }
}
