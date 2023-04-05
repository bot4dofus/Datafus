package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismFightStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7030;
       
      
      private var _isInitialized:Boolean = false;
      
      public var state:uint = 0;
      
      public function PrismFightStateUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7030;
      }
      
      public function initPrismFightStateUpdateMessage(state:uint = 0) : PrismFightStateUpdateMessage
      {
         this.state = state;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.state = 0;
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
         this.serializeAs_PrismFightStateUpdateMessage(output);
      }
      
      public function serializeAs_PrismFightStateUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element state.");
         }
         output.writeByte(this.state);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightStateUpdateMessage(input);
      }
      
      public function deserializeAs_PrismFightStateUpdateMessage(input:ICustomDataInput) : void
      {
         this._stateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismFightStateUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismFightStateUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._stateFunc);
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of PrismFightStateUpdateMessage.state.");
         }
      }
   }
}
