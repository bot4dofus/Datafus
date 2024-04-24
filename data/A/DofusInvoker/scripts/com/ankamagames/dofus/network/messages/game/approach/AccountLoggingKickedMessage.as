package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AccountLoggingKickedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4552;
       
      
      private var _isInitialized:Boolean = false;
      
      public var days:uint = 0;
      
      public var hours:uint = 0;
      
      public var minutes:uint = 0;
      
      public function AccountLoggingKickedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4552;
      }
      
      public function initAccountLoggingKickedMessage(days:uint = 0, hours:uint = 0, minutes:uint = 0) : AccountLoggingKickedMessage
      {
         this.days = days;
         this.hours = hours;
         this.minutes = minutes;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.days = 0;
         this.hours = 0;
         this.minutes = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AccountLoggingKickedMessage(output);
      }
      
      public function serializeAs_AccountLoggingKickedMessage(output:ICustomDataOutput) : void
      {
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element days.");
         }
         output.writeVarShort(this.days);
         if(this.hours < 0)
         {
            throw new Error("Forbidden value (" + this.hours + ") on element hours.");
         }
         output.writeByte(this.hours);
         if(this.minutes < 0)
         {
            throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
         }
         output.writeByte(this.minutes);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccountLoggingKickedMessage(input);
      }
      
      public function deserializeAs_AccountLoggingKickedMessage(input:ICustomDataInput) : void
      {
         this._daysFunc(input);
         this._hoursFunc(input);
         this._minutesFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccountLoggingKickedMessage(tree);
      }
      
      public function deserializeAsyncAs_AccountLoggingKickedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._daysFunc);
         tree.addChild(this._hoursFunc);
         tree.addChild(this._minutesFunc);
      }
      
      private function _daysFunc(input:ICustomDataInput) : void
      {
         this.days = input.readVarUhShort();
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element of AccountLoggingKickedMessage.days.");
         }
      }
      
      private function _hoursFunc(input:ICustomDataInput) : void
      {
         this.hours = input.readByte();
         if(this.hours < 0)
         {
            throw new Error("Forbidden value (" + this.hours + ") on element of AccountLoggingKickedMessage.hours.");
         }
      }
      
      private function _minutesFunc(input:ICustomDataInput) : void
      {
         this.minutes = input.readByte();
         if(this.minutes < 0)
         {
            throw new Error("Forbidden value (" + this.minutes + ") on element of AccountLoggingKickedMessage.minutes.");
         }
      }
   }
}
