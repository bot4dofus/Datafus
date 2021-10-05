package com.ankamagames.dofus.logic.common.utils
{
   import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.network.messages.game.basic.BasicAckMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.getTimer;
   
   public class LagometerAck extends Lagometer
   {
       
      
      private var _msgTimeStack:Vector.<uint>;
      
      private var _active:Boolean = false;
      
      private var _optionId:uint;
      
      public function LagometerAck()
      {
         this._msgTimeStack = new Vector.<uint>();
         super();
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword("system.lagByAck");
         if(feature)
         {
            this._optionId = feature.id;
         }
      }
      
      override public function stop() : void
      {
         if(_timer.running)
         {
            _timer.stop();
         }
         this._msgTimeStack.length = 0;
      }
      
      override public function ping(msg:INetworkMessage = null) : void
      {
         var featureManager:FeatureManager = null;
         if(!this._active)
         {
            featureManager = FeatureManager.getInstance();
            if(featureManager && featureManager.isFeatureWithIdEnabled(this._optionId))
            {
               this._active = true;
            }
         }
         if(!this._active)
         {
            super.ping(msg);
            return;
         }
         if(!this._msgTimeStack.length)
         {
            _timer.delay = SHOW_LAG_DELAY;
            _timer.start();
         }
         this._msgTimeStack.push(getTimer());
      }
      
      override public function pong(msg:INetworkMessage = null) : void
      {
         var latency:uint = 0;
         if(!this._active)
         {
            super.pong(msg);
            return;
         }
         if(msg is BasicAckMessage)
         {
            latency = getTimer() - this._msgTimeStack.shift();
            if(latency > SHOW_LAG_DELAY)
            {
               _log.debug(latency + " ms de latence (basé sur ACK)");
               startLag();
               if(_timer.running)
               {
                  _timer.stop();
               }
            }
            else
            {
               stopLag();
               if(this._msgTimeStack.length)
               {
                  _timer.delay = Math.max(0,SHOW_LAG_DELAY - (getTimer() - this._msgTimeStack[0]));
                  _timer.start();
               }
               else
               {
                  _timer.stop();
               }
            }
         }
      }
   }
}
