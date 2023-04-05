package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.types.enums.StackActionEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.display.Sprite;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractBehavior
   {
      
      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(AbstractBehavior));
      
      public static const NORMAL:String = "normal";
      
      public static const STOP:String = "stop";
      
      public static const ALWAYS:String = "always";
       
      
      public var type:String;
      
      public var isAvailableToStart:Boolean = false;
      
      public var canBeStacked:Boolean = true;
      
      public var isActive:Boolean = true;
      
      public var position:MapPoint;
      
      public var error:Boolean = false;
      
      public var actionStarted:Boolean = false;
      
      public var sprite:Sprite;
      
      private var _pendingMessage:Message;
      
      private var _processedMessage:Message;
      
      public function AbstractBehavior()
      {
         super();
      }
      
      public static function createFake(type:String, params:Array = null) : AbstractBehavior
      {
         var behavior:AbstractBehavior = null;
         switch(type)
         {
            case StackActionEnum.MOVE:
               behavior = new MoveBehavior();
               behavior.position = params[0];
         }
         return behavior;
      }
      
      public function get pendingMessage() : Message
      {
         return this._pendingMessage;
      }
      
      public function set pendingMessage(msg:Message) : void
      {
         this._pendingMessage = msg;
         if(this._pendingMessage && Object(this._pendingMessage).hasOwnProperty("fromStack"))
         {
            this._pendingMessage["fromStack"] = true;
         }
      }
      
      public function get processedMessage() : Message
      {
         return this._processedMessage;
      }
      
      public function processInputMessage(pMsgToProcess:Message, pMode:String) : Boolean
      {
         throw new AbstractMethodCallError();
      }
      
      public function processOutputMessage(pMsgToProcess:Message, pMode:String) : Boolean
      {
         throw new AbstractMethodCallError();
      }
      
      public function processMessageToWorker() : void
      {
         Kernel.getWorker().process(this.pendingMessage);
         this._processedMessage = this.pendingMessage;
         this.pendingMessage = null;
      }
      
      public function isAvailableToProcess(pMsg:Message) : Boolean
      {
         return true;
      }
      
      public function copy() : AbstractBehavior
      {
         throw new AbstractMethodCallError();
      }
      
      public function checkAvailability(pMsgToProcess:Message) : void
      {
      }
      
      public function reset() : void
      {
         this.pendingMessage = null;
         this.actionStarted = false;
      }
      
      public function getMapPoint() : MapPoint
      {
         return this.position;
      }
      
      public function remove() : void
      {
         this.sprite = null;
      }
      
      public function isMessageCatchable(pMsg:Message) : Boolean
      {
         return false;
      }
      
      public function addIcon() : void
      {
      }
      
      public function removeIcon() : void
      {
      }
      
      public function get canBeRemoved() : Boolean
      {
         return true;
      }
      
      public function get needToWait() : Boolean
      {
         return false;
      }
      
      public function getFakePosition() : MapPoint
      {
         return null;
      }
   }
}
