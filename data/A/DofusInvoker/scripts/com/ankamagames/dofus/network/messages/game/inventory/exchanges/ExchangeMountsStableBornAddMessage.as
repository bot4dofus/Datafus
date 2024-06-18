package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeMountsStableBornAddMessage extends ExchangeMountsStableAddMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2861;
       
      
      private var _isInitialized:Boolean = false;
      
      public function ExchangeMountsStableBornAddMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2861;
      }
      
      public function initExchangeMountsStableBornAddMessage(mountDescription:Vector.<MountClientData> = null) : ExchangeMountsStableBornAddMessage
      {
         super.initExchangeMountsStableAddMessage(mountDescription);
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
         this.serializeAs_ExchangeMountsStableBornAddMessage(output);
      }
      
      public function serializeAs_ExchangeMountsStableBornAddMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeMountsStableAddMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMountsStableBornAddMessage(input);
      }
      
      public function deserializeAs_ExchangeMountsStableBornAddMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMountsStableBornAddMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMountsStableBornAddMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
