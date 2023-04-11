package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.livingObjects.SpeakingItemText;
   import com.ankamagames.dofus.datacenter.livingObjects.SpeakingItemsTrigger;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectMessageRequestMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import flash.events.TimerEvent;
   
   public class SpeakingItemManager implements IDestroyable
   {
      
      private static const SPEAKING_ITEMS_MSG_COUNT:Number = 30;
      
      private static const SPEAKING_ITEMS_MSG_COUNT_DELTA:Number = 0.2;
      
      private static const SPEAKING_ITEMS_CHAT_PROBA:Number = 0.01;
      
      private static var _timer:BenchmarkTimer;
      
      public static const MINUTE_DELAY:int = 1000 * 60;
      
      public static const GREAT_DROP_LIMIT:int = 10;
      
      public static const SPEAK_TRIGGER_MINUTE:int = 1;
      
      public static const SPEAK_TRIGGER_AGRESS:int = 2;
      
      public static const SPEAK_TRIGGER_AGRESSED:int = 3;
      
      public static const SPEAK_TRIGGER_KILL_ENEMY:int = 4;
      
      public static const SPEAK_TRIGGER_KILLED_BY_ENEMY:int = 5;
      
      public static const SPEAK_TRIGGER_CC_OWNER:int = 6;
      
      public static const SPEAK_TRIGGER_EC_OWNER:int = 7;
      
      public static const SPEAK_TRIGGER_FIGHT_WON:int = 8;
      
      public static const SPEAK_TRIGGER_FIGHT_LOST:int = 9;
      
      public static const SPEAK_TRIGGER_NEW_ENEMY_WEAK:int = 10;
      
      public static const SPEAK_TRIGGER_NEW_ENEMY_STRONG:int = 11;
      
      public static const SPEAK_TRIGGER_CC_ALLIED:int = 12;
      
      public static const SPEAK_TRIGGER_EC_ALLIED:int = 13;
      
      public static const SPEAK_TRIGGER_CC_ENEMY:int = 14;
      
      public static const SPEAK_TRIGGER_EC_ENEMY:int = 15;
      
      public static const SPEAK_TRIGGER_ON_CONNECT:int = 16;
      
      public static const SPEAK_TRIGGER_KILL_ALLY:int = 17;
      
      public static const SPEAK_TRIGGER_KILLED_BY_ALLY:int = 18;
      
      public static const SPEAK_TRIGGER_GREAT_DROP:int = 19;
      
      public static const SPEAK_TRIGGER_KILLED_HIMSELF:int = 20;
      
      public static const SPEAK_TRIGGER_CRAFT_OK:int = 21;
      
      public static const SPEAK_TRIGGER_CRAFT_KO:int = 22;
      
      public static const SPEAK_TRIGGER_NEW_MAP:int = 23;
      
      public static const SPEAK_TRIGGER_MOVE:int = 24;
      
      public static const SPEAK_TRIGGER_PLAYER_LOOSE_LIFE:int = 25;
      
      public static const SPEAK_TRIGGER_ALLIED_LOOSE_LIFE:int = 26;
      
      public static const SPEAK_TRIGGER_ENEMY_LOOSE_LIFE:int = 27;
      
      public static const SPEAK_TRIGGER_PLAYER_TURN_START:int = 28;
      
      public static const SPEAK_TRIGGER_PLAYER_CLOSE_COMBAT:int = 29;
      
      public static const SPEAK_TRIGGER_PLAYER_TACKLED:int = 30;
      
      private static var _self:SpeakingItemManager;
       
      
      private var _nextMessageCount:int;
      
      public function SpeakingItemManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("TimeManager is a singleton and should not be instanciated directly.");
         }
         this.init();
      }
      
      public static function getInstance() : SpeakingItemManager
      {
         if(_self == null)
         {
            _self = new SpeakingItemManager();
         }
         return _self;
      }
      
      public function get speakTimerMinuteDelay() : int
      {
         return _timer.delay;
      }
      
      public function set speakTimerMinuteDelay(delay:int) : void
      {
         _timer.delay = delay;
         _timer.stop();
         _timer.start();
      }
      
      public function triggerEvent(nEvent:int) : void
      {
         var item:ItemWrapper = null;
         var strId:String = null;
         var i:int = 0;
         var msgId:Number = NaN;
         var ok:Boolean = false;
         var media:Number = NaN;
         var speakingText:SpeakingItemText = null;
         var restriction:Array = null;
         var msg:LivingObjectMessageRequestMessage = null;
         Chrono.start("SpeakingEntitiesManager");
         SpeakingEntitiesManager.getInstance().triggerEvent(nEvent);
         Chrono.stop();
         if(!Kernel.getWorker().getFrame(ChatFrame))
         {
            return;
         }
         var opt:Boolean = OptionManager.getOptionManager("chat").getOption("letLivingObjectTalk");
         if(!opt)
         {
            return;
         }
         var items:Array = new Array();
         for each(item in InventoryManager.getInstance().inventory.getView("equipment").content)
         {
            if(item && item.isSpeakingObject)
            {
               items.push(item);
            }
         }
         if(items.length == 0)
         {
            return;
         }
         --this._nextMessageCount;
         this._nextMessageCount -= (items.length - 1) / 4;
         if(this._nextMessageCount > 0)
         {
            return;
         }
         var triggersAssoc:SpeakingItemsTrigger = SpeakingItemsTrigger.getSpeakingItemsTriggerById(nEvent);
         var itemWrapper:ItemWrapper = items[Math.floor(Math.random() * items.length)];
         var tmpTriggersAssoc:Array = new Array();
         if(triggersAssoc)
         {
            strId = itemWrapper.objectGID.toString();
            for(i = 0; i < triggersAssoc.textIds.length; i++)
            {
               if(!(itemWrapper.isLivingObject && triggersAssoc.states[i] != itemWrapper.livingObjectMood))
               {
                  speakingText = SpeakingItemText.getSpeakingItemTextById(triggersAssoc.textIds[i]);
                  if(speakingText)
                  {
                     if(!(speakingText.textLevel > itemWrapper.livingObjectLevel && itemWrapper.isLivingObject))
                     {
                        restriction = speakingText.textRestriction.split(",");
                        if(!(speakingText.textRestriction != "" && restriction.indexOf(strId) == -1))
                        {
                           tmpTriggersAssoc.push(triggersAssoc.textIds[i]);
                        }
                     }
                  }
               }
            }
            if(tmpTriggersAssoc.length == 0)
            {
               return;
            }
            ok = false;
            for(i = 0; i < 10; i++)
            {
               msgId = tmpTriggersAssoc[Math.floor(Math.random() * tmpTriggersAssoc.length)];
               speakingText = SpeakingItemText.getSpeakingItemTextById(msgId);
               if(Math.random() < speakingText.textProba)
               {
                  ok = true;
               }
            }
            if(!ok)
            {
               return;
            }
            if(speakingText.textSound != -1)
            {
               media = Math.floor(Math.random() * 3);
            }
            else
            {
               media = 1;
            }
            if(Math.random() < SPEAKING_ITEMS_CHAT_PROBA)
            {
               msg = new LivingObjectMessageRequestMessage();
               msg.initLivingObjectMessageRequestMessage(speakingText.textId,new Vector.<String>(),itemWrapper.objectUID);
               ConnectionsHandler.getConnection().send(msg);
            }
            else
            {
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatSpeakingItem,ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE,itemWrapper,speakingText.textString,TimeManager.getInstance().getTimestamp());
            }
         }
         this.generateNextMsgCount(false);
      }
      
      public function destroy() : void
      {
         _self = null;
         _timer.removeEventListener("timer",this.onTimer);
      }
      
      private function init() : void
      {
         _timer = new BenchmarkTimer(MINUTE_DELAY,0,"SpeakingItemManager._timer");
         _timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         _timer.start();
         this.generateNextMsgCount(true);
      }
      
      private function generateNextMsgCount(noMin:Boolean) : void
      {
         var msgCount:Number = SPEAKING_ITEMS_MSG_COUNT;
         var delta:Number = SPEAKING_ITEMS_MSG_COUNT_DELTA;
         if(noMin)
         {
            this._nextMessageCount = Math.floor(msgCount * Math.random());
         }
         else
         {
            this._nextMessageCount = msgCount + Math.floor(2 * delta * Math.random());
         }
      }
      
      private function onTimer(event:TimerEvent) : void
      {
         this.triggerEvent(SPEAK_TRIGGER_MINUTE);
      }
   }
}
