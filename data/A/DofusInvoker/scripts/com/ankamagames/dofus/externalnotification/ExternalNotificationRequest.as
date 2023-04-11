package com.ankamagames.dofus.externalnotification
{
   import com.ankamagames.jerakine.json.JSON;
   
   public class ExternalNotificationRequest
   {
       
      
      private var _notificationType:int;
      
      private var _clientId:String;
      
      private var _otherClientsIds:Array;
      
      private var _id:String;
      
      private var _showMode:int;
      
      private var _hookName:String;
      
      private var _hookParams:Array;
      
      private var _uiName:String;
      
      private var _displayData:Object;
      
      private var _soundId:String;
      
      private var _playSound:Boolean;
      
      private var _notify:Boolean;
      
      private var _duration:int = 0;
      
      public function ExternalNotificationRequest(pNotificationType:int, pClientId:String, pOtherClientsIds:Array, pId:String, pShowMode:int, pUiName:String, pDisplayData:Object, duration:int, pSoundId:String, pPlaySound:Boolean, pNotify:Boolean, pHookName:String = null, pHookParams:Array = null)
      {
         super();
         this._notificationType = pNotificationType;
         this._clientId = pClientId;
         this._otherClientsIds = pOtherClientsIds;
         this._id = pId;
         this._showMode = pShowMode;
         this._uiName = pUiName;
         this._displayData = pDisplayData;
         this._duration = duration;
         this._soundId = pSoundId;
         this._playSound = pPlaySound;
         this._notify = pNotify;
         this._hookName = pHookName;
         this._hookParams = pHookParams;
      }
      
      public static function createFromJSONString(pJSONStr:String) : ExternalNotificationRequest
      {
         var obj:Object = com.ankamagames.jerakine.json.JSON.decode(pJSONStr);
         return new ExternalNotificationRequest(obj.notificationType,obj.clientId,obj.otherClientsIds,obj.id,obj.showMode,obj.uiName,obj.displayData,obj.duration,obj.soundId,obj.playSound,obj.notify,obj.hookName,obj.hookParams);
      }
      
      public function get notificationType() : int
      {
         return this._notificationType;
      }
      
      public function get instanceId() : String
      {
         return this._clientId + "#" + this._id;
      }
      
      public function get clientId() : String
      {
         return this._clientId;
      }
      
      public function get otherClientsIds() : Array
      {
         return this._otherClientsIds;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get showMode() : int
      {
         return this._showMode;
      }
      
      public function get uiName() : String
      {
         return this._uiName;
      }
      
      public function get displayData() : Object
      {
         return this._displayData;
      }
      
      public function get soundId() : String
      {
         return this._soundId;
      }
      
      public function get hookName() : String
      {
         return this._hookName;
      }
      
      public function get hookParams() : Array
      {
         return this._hookParams;
      }
      
      public function get playSound() : Boolean
      {
         return this._playSound;
      }
      
      public function get notify() : Boolean
      {
         return this._notify;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
   }
}
