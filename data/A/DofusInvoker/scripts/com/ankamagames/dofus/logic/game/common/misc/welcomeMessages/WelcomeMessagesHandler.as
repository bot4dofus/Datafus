package com.ankamagames.dofus.logic.game.common.misc.welcomeMessages
{
   import com.ankama.haapi.client.model.CmsFeed;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class WelcomeMessagesHandler
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(WelcomeMessagesHandler));
       
      
      private var _messagesToBeDisplayed:Vector.<WelcomeMessageWrapper>;
      
      private var _messagesToExpire:Vector.<WelcomeMessageWrapper>;
      
      private var _displayTimer:BenchmarkTimer = null;
      
      private var _expirationTimer:BenchmarkTimer = null;
      
      private var _listeners:Vector.<Function>;
      
      public function WelcomeMessagesHandler()
      {
         this._messagesToBeDisplayed = new Vector.<WelcomeMessageWrapper>();
         this._messagesToExpire = new Vector.<WelcomeMessageWrapper>();
         this._listeners = new Vector.<Function>(0);
         super();
      }
      
      private function dispatchMessage(message:WelcomeMessageWrapper) : void
      {
         var listener:Function = null;
         if(message.hasExpired || !message.isDisplayedOnCurrentServer)
         {
            return;
         }
         for each(listener in this._listeners)
         {
            listener.apply(null,[message]);
         }
      }
      
      private function startDisplayTimer(displayTime:Number) : void
      {
         var duration:Number = displayTime - TimeManager.getInstance().getUtcTimestamp();
         if(duration < 0)
         {
            return;
         }
         if(this._displayTimer !== null)
         {
            this.destroyDisplayTimer();
         }
         this._displayTimer = new BenchmarkTimer(duration,0,"WelcomeMessageHandler._displayTimer");
         this._displayTimer.addEventListener(TimerEvent.TIMER,this.onDisplayTimer);
         this._displayTimer.start();
      }
      
      private function destroyDisplayTimer() : void
      {
         if(this._displayTimer === null)
         {
            return;
         }
         this._displayTimer.stop();
         this._displayTimer.removeEventListener(TimerEvent.TIMER,this.onDisplayTimer);
         this._displayTimer = null;
      }
      
      private function startExpirationTimer(expirationTime:Number) : void
      {
         var duration:Number = expirationTime - TimeManager.getInstance().getUtcTimestamp();
         if(duration < 0)
         {
            return;
         }
         if(this._expirationTimer !== null)
         {
            this.destroyExpirationTimer();
         }
         this._expirationTimer = new BenchmarkTimer(duration,0,"WelcomeMessageHandler._expirationTimer");
         this._expirationTimer.addEventListener(TimerEvent.TIMER,this.onExpirationTimer);
         this._expirationTimer.start();
      }
      
      private function destroyExpirationTimer() : void
      {
         if(this._expirationTimer === null)
         {
            return;
         }
         this._expirationTimer.stop();
         this._expirationTimer.removeEventListener(TimerEvent.TIMER,this.onDisplayTimer);
         this._expirationTimer = null;
      }
      
      public function addRawMessages(rawMessages:Array) : void
      {
         var messageDescr:CmsFeed = null;
         var message:WelcomeMessageWrapper = null;
         for each(messageDescr in rawMessages)
         {
            message = WelcomeMessageWrapper.wrap(messageDescr);
            if(!this.addMessage(message))
            {
               _log.debug("Welcome message not added: " + messageDescr.id.toString() + ".");
            }
         }
      }
      
      public function addMessage(message:WelcomeMessageWrapper) : Boolean
      {
         if(message.canBeDisplayed)
         {
            return this.addMessageToExpire(message);
         }
         if(!message.hasExpired)
         {
            return this.addMessageToBeDisplayed(message);
         }
         _log.error("Trying to add an expired message: " + message.id.toString() + ".");
         return false;
      }
      
      public function addListener(listener:Function) : void
      {
         var message:WelcomeMessageWrapper = null;
         this._listeners.push(listener);
         for each(message in this._messagesToExpire)
         {
            listener(message);
         }
      }
      
      public function reset() : void
      {
         this.destroyDisplayTimer();
         this.destroyExpirationTimer();
         this._messagesToBeDisplayed = new Vector.<WelcomeMessageWrapper>();
         this._messagesToExpire = new Vector.<WelcomeMessageWrapper>();
      }
      
      private function addMessageToBeDisplayed(newMessage:WelcomeMessageWrapper) : Boolean
      {
         var message:WelcomeMessageWrapper = null;
         if(!newMessage.isValid)
         {
            _log.error("New message to be displayed is not valid: " + newMessage.id + ".");
            return false;
         }
         var i:int = this._messagesToBeDisplayed.length;
         while(i > 0)
         {
            message = this._messagesToBeDisplayed[i - 1];
            if(message.displayTime > newMessage.displayTime)
            {
               break;
            }
            i--;
         }
         this._messagesToBeDisplayed.insertAt(i,newMessage);
         if(i === this._messagesToBeDisplayed.length - 1)
         {
            this.destroyDisplayTimer();
            this.startDisplayTimer(newMessage.displayTime);
         }
         return true;
      }
      
      private function addMessageToExpire(newMessage:WelcomeMessageWrapper) : Boolean
      {
         var message:WelcomeMessageWrapper = null;
         if(!newMessage.isValid || !newMessage.canBeDisplayed)
         {
            _log.error("New message to expire is not valid or cannot be displayed: " + newMessage.id + ".");
            return false;
         }
         var i:int = this._messagesToExpire.length;
         while(i > 0)
         {
            message = this._messagesToExpire[i - 1];
            if(message.expirationTime > newMessage.expirationTime)
            {
               break;
            }
            i--;
         }
         this._messagesToExpire.insertAt(i,newMessage);
         if(i === this._messagesToExpire.length - 1)
         {
            this.destroyExpirationTimer();
            this.startExpirationTimer(newMessage.expirationTime);
         }
         this.dispatchMessage(newMessage);
         return true;
      }
      
      private function onDisplayTimer(event:TimerEvent) : void
      {
         this.destroyDisplayTimer();
         var message:WelcomeMessageWrapper = this._messagesToBeDisplayed.pop();
         this.dispatchMessage(message);
         this.addMessageToExpire(message);
         if(this._messagesToBeDisplayed.length > 0)
         {
            this.startDisplayTimer(this._messagesToBeDisplayed[this._messagesToBeDisplayed.length - 1].displayTime);
         }
      }
      
      private function onExpirationTimer(event:TimerEvent) : void
      {
         this.destroyExpirationTimer();
         this._messagesToExpire.pop();
         if(this._messagesToExpire.length > 0)
         {
            this.startExpirationTimer(this._messagesToExpire[this._messagesToExpire.length - 1].expirationTime);
         }
      }
   }
}
