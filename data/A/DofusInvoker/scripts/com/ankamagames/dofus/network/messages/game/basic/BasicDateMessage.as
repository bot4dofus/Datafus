package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicDateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7499;
       
      
      private var _isInitialized:Boolean = false;
      
      public var day:uint = 0;
      
      public var month:uint = 0;
      
      public var year:uint = 0;
      
      public function BasicDateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7499;
      }
      
      public function initBasicDateMessage(day:uint = 0, month:uint = 0, year:uint = 0) : BasicDateMessage
      {
         this.day = day;
         this.month = month;
         this.year = year;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.day = 0;
         this.month = 0;
         this.year = 0;
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
         this.serializeAs_BasicDateMessage(output);
      }
      
      public function serializeAs_BasicDateMessage(output:ICustomDataOutput) : void
      {
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element day.");
         }
         output.writeByte(this.day);
         if(this.month < 0)
         {
            throw new Error("Forbidden value (" + this.month + ") on element month.");
         }
         output.writeByte(this.month);
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element year.");
         }
         output.writeShort(this.year);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicDateMessage(input);
      }
      
      public function deserializeAs_BasicDateMessage(input:ICustomDataInput) : void
      {
         this._dayFunc(input);
         this._monthFunc(input);
         this._yearFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicDateMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicDateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dayFunc);
         tree.addChild(this._monthFunc);
         tree.addChild(this._yearFunc);
      }
      
      private function _dayFunc(input:ICustomDataInput) : void
      {
         this.day = input.readByte();
         if(this.day < 0)
         {
            throw new Error("Forbidden value (" + this.day + ") on element of BasicDateMessage.day.");
         }
      }
      
      private function _monthFunc(input:ICustomDataInput) : void
      {
         this.month = input.readByte();
         if(this.month < 0)
         {
            throw new Error("Forbidden value (" + this.month + ") on element of BasicDateMessage.month.");
         }
      }
      
      private function _yearFunc(input:ICustomDataInput) : void
      {
         this.year = input.readShort();
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element of BasicDateMessage.year.");
         }
      }
   }
}
