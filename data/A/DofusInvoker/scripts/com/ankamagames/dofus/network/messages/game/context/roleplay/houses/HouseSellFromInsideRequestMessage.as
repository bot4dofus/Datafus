package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseSellFromInsideRequestMessage extends HouseSellRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6061;
       
      
      private var _isInitialized:Boolean = false;
      
      public function HouseSellFromInsideRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6061;
      }
      
      public function initHouseSellFromInsideRequestMessage(instanceId:uint = 0, amount:Number = 0, forSale:Boolean = false) : HouseSellFromInsideRequestMessage
      {
         super.initHouseSellRequestMessage(instanceId,amount,forSale);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseSellFromInsideRequestMessage(output);
      }
      
      public function serializeAs_HouseSellFromInsideRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_HouseSellRequestMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseSellFromInsideRequestMessage(input);
      }
      
      public function deserializeAs_HouseSellFromInsideRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseSellFromInsideRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseSellFromInsideRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
