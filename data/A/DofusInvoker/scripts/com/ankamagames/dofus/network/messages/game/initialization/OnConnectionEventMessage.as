package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class OnConnectionEventMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3041;
       
      
      private var _isInitialized:Boolean = false;
      
      public var eventType:uint = 0;
      
      public function OnConnectionEventMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3041;
      }
      
      public function initOnConnectionEventMessage(eventType:uint = 0) : OnConnectionEventMessage
      {
         this.eventType = eventType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.eventType = 0;
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
         this.serializeAs_OnConnectionEventMessage(output);
      }
      
      public function serializeAs_OnConnectionEventMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.eventType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_OnConnectionEventMessage(input);
      }
      
      public function deserializeAs_OnConnectionEventMessage(input:ICustomDataInput) : void
      {
         this._eventTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_OnConnectionEventMessage(tree);
      }
      
      public function deserializeAsyncAs_OnConnectionEventMessage(tree:FuncTree) : void
      {
         tree.addChild(this._eventTypeFunc);
      }
      
      private function _eventTypeFunc(input:ICustomDataInput) : void
      {
         this.eventType = input.readByte();
         if(this.eventType < 0)
         {
            throw new Error("Forbidden value (" + this.eventType + ") on element of OnConnectionEventMessage.eventType.");
         }
      }
   }
}
