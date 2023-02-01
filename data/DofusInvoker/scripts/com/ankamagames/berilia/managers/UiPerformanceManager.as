package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.Version;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class UiPerformanceManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiPerformanceManager));
      
      private static const DATASTORE_CATEGORY_STATS:String = "uiStats";
      
      private static const LASTSUBMISSIONVERSION_KEY_STATS:String = "lastSubmissionClientVersion";
      
      private static const REQUIRED_TOTAL_UI_BEFORE_SUBMISSION:uint = 24;
      
      private static var _singleton:UiPerformanceManager;
       
      
      public var statsEnabled:Boolean = false;
      
      private var _uiLoadStats:Object;
      
      private var _alreadyOpenedUis:Dictionary;
      
      private var _currentVersion:Version;
      
      private var _hasToCollectStats:Boolean;
      
      public function UiPerformanceManager()
      {
         super();
         this._uiLoadStats = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_STATS,DATASTORE_CATEGORY_STATS,new Object());
         this._alreadyOpenedUis = new Dictionary();
         this._hasToCollectStats = false;
      }
      
      public static function getInstance() : UiPerformanceManager
      {
         if(!_singleton)
         {
            _singleton = new UiPerformanceManager();
         }
         return _singleton;
      }
      
      public function set currentVersion(v:Version) : void
      {
         this._currentVersion = v;
         var savedVersion:Object = this._uiLoadStats[LASTSUBMISSIONVERSION_KEY_STATS];
         if(savedVersion && (savedVersion.major != this._currentVersion.major && savedVersion.minor != this._currentVersion.minor))
         {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_STATS,DATASTORE_CATEGORY_STATS,new Object());
            this._hasToCollectStats = true;
         }
         else if(!savedVersion)
         {
            this._hasToCollectStats = true;
         }
         else
         {
            this._hasToCollectStats = false;
         }
      }
      
      public function reset() : void
      {
         this._alreadyOpenedUis = new Dictionary();
      }
      
      public function saveUiLoadStats(uiName:String, uiLoadStats:Object) : void
      {
         var destKey:* = null;
         var srcKey:* = null;
         if(!this._hasToCollectStats)
         {
            return;
         }
         if(!uiName)
         {
            _log.error("Can\'t save UI stats without an UI name!");
            return;
         }
         var xmlExtensionIndex:int = uiName.toLowerCase().indexOf(".xml");
         if(xmlExtensionIndex != -1)
         {
            uiName = uiName.substring(uiName.lastIndexOf("/") + 1,xmlExtensionIndex);
         }
         if(uiName.indexOf("tooltip") != -1)
         {
            return;
         }
         if(!this._uiLoadStats.stats)
         {
            this._uiLoadStats.stats = new Object();
         }
         if(this._alreadyOpenedUis.hasOwnProperty(uiName) == false)
         {
            destKey = uiName + "_first";
         }
         else
         {
            destKey = uiName;
         }
         if(!this._uiLoadStats.stats[destKey])
         {
            this._uiLoadStats.stats[destKey] = new Object();
         }
         for(srcKey in uiLoadStats)
         {
            if(!this._uiLoadStats.stats[destKey][srcKey])
            {
               this._uiLoadStats.stats[destKey][srcKey] = [uiLoadStats[srcKey]];
            }
            else
            {
               this._uiLoadStats.stats[destKey][srcKey].push(uiLoadStats[srcKey]);
            }
         }
         this._alreadyOpenedUis[uiName] = true;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_STATS,DATASTORE_CATEGORY_STATS,this._uiLoadStats);
      }
      
      public function get averageUiLoadStats() : Object
      {
         var times:Array = null;
         var uiKey:* = null;
         var timeKey:* = null;
         var averageTime:uint = 0;
         var i:int = 0;
         var stats:Object = new Object();
         if(this._uiLoadStats.hasOwnProperty("stats"))
         {
            for(uiKey in this._uiLoadStats.stats)
            {
               for(timeKey in this._uiLoadStats.stats[uiKey])
               {
                  times = this._uiLoadStats.stats[uiKey][timeKey];
                  averageTime = 0;
                  for(i = 0; i < times.length; i++)
                  {
                     averageTime += times[i];
                  }
                  averageTime /= times.length;
                  stats["ui_" + uiKey + "_" + timeKey] = averageTime;
               }
            }
         }
         return stats;
      }
      
      public function get needUiLoadStatsSubmission() : Boolean
      {
         var key:* = null;
         var totalUis:uint = 0;
         for(key in this._uiLoadStats.stats)
         {
            if(key.indexOf("_first") != -1)
            {
               totalUis++;
            }
         }
         return this._hasToCollectStats && totalUis >= REQUIRED_TOTAL_UI_BEFORE_SUBMISSION;
      }
      
      public function markCurrentVersionAsUploaded() : void
      {
         this._uiLoadStats[LASTSUBMISSIONVERSION_KEY_STATS] = {
            "major":this._currentVersion.major,
            "minor":this._currentVersion.minor
         };
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_STATS,DATASTORE_CATEGORY_STATS,this._uiLoadStats);
      }
   }
}
