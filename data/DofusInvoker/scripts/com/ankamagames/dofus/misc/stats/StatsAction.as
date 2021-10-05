package com.ankamagames.dofus.misc.stats
{
   import by.blooddy.crypto.MD5;
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import mx.formatters.DateFormatter;
   
   public class StatsAction
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(StatsAction));
      
      private static var _usersActions:Dictionary = new Dictionary();
       
      
      private var _id:uint;
      
      private var _timestamp:Number;
      
      private var _persistent:Boolean;
      
      private var _aggregate:Boolean;
      
      private var _addTimestamp:Boolean;
      
      private var _startTime:uint;
      
      private var _started:Boolean;
      
      private var _params:Object;
      
      private var _date:Date;
      
      private var _sendOnExit:Boolean;
      
      private var _userId:String;
      
      private var _gameSessionId:Number;
      
      public function StatsAction(pId:uint, pPersistent:Boolean = false, pAggregate:Boolean = false, pAddTimestamp:Boolean = false, pSendOnExit:Boolean = false)
      {
         super();
         this._id = pId;
         this._persistent = pPersistent;
         this._aggregate = pAggregate;
         this._addTimestamp = pAddTimestamp;
         this._sendOnExit = pSendOnExit;
         this._params = new Object();
      }
      
      public static function getUserId() : String
      {
         var loginUi:UiRootContainer = null;
         var login:String = AuthentificationManager.getInstance().username;
         if(!login)
         {
            loginUi = Berilia.getInstance().getUi("login");
            if(loginUi && loginUi.uiClass)
            {
               login = loginUi.uiClass.cbx_login.input.text;
            }
         }
         if(login)
         {
            return "user-" + MD5.hash(login);
         }
         return null;
      }
      
      public static function get(pStatsActionId:uint, pPersistent:Boolean = false, pAggregate:Boolean = false, pAddTimestamp:Boolean = false, pSendOnExit:Boolean = false) : StatsAction
      {
         var sa:StatsAction = null;
         var userId:String = getUserId();
         if(!_usersActions[pStatsActionId])
         {
            sa = new StatsAction(pStatsActionId,pPersistent,pAggregate,pAddTimestamp,pSendOnExit);
            sa._userId = userId;
            sa._gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
            _usersActions[pStatsActionId] = sa;
         }
         return _usersActions[pStatsActionId];
      }
      
      public static function fromString(pString:String) : StatsAction
      {
         var obj:Object = null;
         var sa:StatsAction = null;
         var param:* = undefined;
         try
         {
            obj = by.blooddy.crypto.serialization.JSON.decode(pString);
            sa = new StatsAction(obj.event_id);
            if(obj.hasOwnProperty("user"))
            {
               sa._userId = obj.user;
            }
            if(obj.hasOwnProperty("gameSessionId"))
            {
               sa._gameSessionId = obj.gameSessionId;
            }
            for(param in obj.data)
            {
               sa.setParam(param,obj.data[param]);
            }
            sa.date = DateFormatter.parseDateString(obj.date);
            return sa;
         }
         catch(e:Error)
         {
            _log.warn("Invalid event data from cache : " + pString);
            return null;
         }
      }
      
      public static function exists(pStatsActionId:uint) : Boolean
      {
         return _usersActions[pStatsActionId];
      }
      
      public static function reset() : void
      {
         _usersActions = new Dictionary();
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get params() : Object
      {
         return this._params;
      }
      
      public function get paramsString() : String
      {
         return by.blooddy.crypto.serialization.JSON.encode(this._params);
      }
      
      public function get date() : Date
      {
         return this._date;
      }
      
      public function set date(pDate:Date) : void
      {
         this._date = pDate;
      }
      
      public function get sendOnExit() : Boolean
      {
         return this._sendOnExit;
      }
      
      public function set sendOnExit(pSendOnExit:Boolean) : void
      {
         this._sendOnExit = pSendOnExit;
      }
      
      public function get user() : String
      {
         return this._userId;
      }
      
      public function set user(pUserId:String) : void
      {
         this._userId = pUserId;
      }
      
      public function set gameSessionId(gameSessionId:Number) : void
      {
         this._gameSessionId = gameSessionId;
      }
      
      public function get gameSessionId() : Number
      {
         return this._gameSessionId;
      }
      
      public function start() : void
      {
         var ts:Number = NaN;
         if(!this._started && this._addTimestamp)
         {
            if(!this._persistent)
            {
               this._timestamp = TimeManager.getInstance().getTimestamp();
               this._startTime = getTimer();
            }
            else
            {
               ts = StatisticsManager.getInstance().getActionTimestamp(this._id);
               if(isNaN(ts))
               {
                  ts = TimeManager.getInstance().getTimestamp();
                  StatisticsManager.getInstance().saveActionTimestamp(this._id,ts);
               }
               this._timestamp = ts;
            }
         }
         this._started = true;
      }
      
      public function restart() : void
      {
         this._started = false;
         this.start();
      }
      
      public function cancel() : void
      {
         delete _usersActions[this._id];
      }
      
      public function updateTimestamp() : void
      {
         this._timestamp = TimeManager.getInstance().getTimestamp();
         if(this._persistent)
         {
            StatisticsManager.getInstance().saveActionTimestamp(this._id,this._timestamp);
         }
      }
      
      public function addParam(pKey:String, pType:uint) : void
      {
      }
      
      public function hasParam(pKey:String) : Boolean
      {
         return this._params.hasOwnProperty(pKey);
      }
      
      public function setParam(pKey:String, pValue:*) : void
      {
         this._params[pKey] = pValue;
      }
      
      public function send() : void
      {
         this._date = new Date();
         if(this._addTimestamp)
         {
            this._params["action_duration_seconds"] = int((!this._persistent ? getTimer() - this._startTime : TimeManager.getInstance().getTimestamp() - this._timestamp) / 1000);
            if(this._persistent)
            {
               StatisticsManager.getInstance().deleteTimeStamp(this._id);
            }
         }
         StatisticsManager.getInstance().sendAction(this);
         delete _usersActions[this._id];
      }
      
      public function toString(backup:Boolean = false) : String
      {
         return "{" + (!!backup ? "\"user\":\"" + this._userId + "\",\"gameSessionId\":" + this._gameSessionId + "," : "") + "\"event_id\":" + this.id + ",\"data\":" + this.paramsString + (!!this.date ? ",\"date\":\"" + StatisticsManager.getInstance().formatDate(this.date) + "\"" : "") + "}";
      }
   }
}
