package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RecycleResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4137;
       
      
      private var _isInitialized:Boolean = false;
      
      public var nuggetsForPrism:uint = 0;
      
      public var nuggetsForPlayer:uint = 0;
      
      public function RecycleResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4137;
      }
      
      public function initRecycleResultMessage(nuggetsForPrism:uint = 0, nuggetsForPlayer:uint = 0) : RecycleResultMessage
      {
         this.nuggetsForPrism = nuggetsForPrism;
         this.nuggetsForPlayer = nuggetsForPlayer;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.nuggetsForPrism = 0;
         this.nuggetsForPlayer = 0;
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
         this.serializeAs_RecycleResultMessage(output);
      }
      
      public function serializeAs_RecycleResultMessage(output:ICustomDataOutput) : void
      {
         if(this.nuggetsForPrism < 0)
         {
            throw new Error("Forbidden value (" + this.nuggetsForPrism + ") on element nuggetsForPrism.");
         }
         output.writeVarInt(this.nuggetsForPrism);
         if(this.nuggetsForPlayer < 0)
         {
            throw new Error("Forbidden value (" + this.nuggetsForPlayer + ") on element nuggetsForPlayer.");
         }
         output.writeVarInt(this.nuggetsForPlayer);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RecycleResultMessage(input);
      }
      
      public function deserializeAs_RecycleResultMessage(input:ICustomDataInput) : void
      {
         this._nuggetsForPrismFunc(input);
         this._nuggetsForPlayerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RecycleResultMessage(tree);
      }
      
      public function deserializeAsyncAs_RecycleResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._nuggetsForPrismFunc);
         tree.addChild(this._nuggetsForPlayerFunc);
      }
      
      private function _nuggetsForPrismFunc(input:ICustomDataInput) : void
      {
         this.nuggetsForPrism = input.readVarUhInt();
         if(this.nuggetsForPrism < 0)
         {
            throw new Error("Forbidden value (" + this.nuggetsForPrism + ") on element of RecycleResultMessage.nuggetsForPrism.");
         }
      }
      
      private function _nuggetsForPlayerFunc(input:ICustomDataInput) : void
      {
         this.nuggetsForPlayer = input.readVarUhInt();
         if(this.nuggetsForPlayer < 0)
         {
            throw new Error("Forbidden value (" + this.nuggetsForPlayer + ") on element of RecycleResultMessage.nuggetsForPlayer.");
         }
      }
   }
}
