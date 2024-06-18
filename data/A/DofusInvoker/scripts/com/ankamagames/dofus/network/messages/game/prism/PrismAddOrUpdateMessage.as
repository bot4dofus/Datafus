package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismAddOrUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1525;
       
      
      private var _isInitialized:Boolean = false;
      
      public var prism:PrismGeolocalizedInformation;
      
      private var _prismtree:FuncTree;
      
      public function PrismAddOrUpdateMessage()
      {
         this.prism = new PrismGeolocalizedInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1525;
      }
      
      public function initPrismAddOrUpdateMessage(prism:PrismGeolocalizedInformation = null) : PrismAddOrUpdateMessage
      {
         this.prism = prism;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.prism = new PrismGeolocalizedInformation();
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
         this.serializeAs_PrismAddOrUpdateMessage(output);
      }
      
      public function serializeAs_PrismAddOrUpdateMessage(output:ICustomDataOutput) : void
      {
         this.prism.serializeAs_PrismGeolocalizedInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismAddOrUpdateMessage(input);
      }
      
      public function deserializeAs_PrismAddOrUpdateMessage(input:ICustomDataInput) : void
      {
         this.prism = new PrismGeolocalizedInformation();
         this.prism.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismAddOrUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismAddOrUpdateMessage(tree:FuncTree) : void
      {
         this._prismtree = tree.addChild(this._prismtreeFunc);
      }
      
      private function _prismtreeFunc(input:ICustomDataInput) : void
      {
         this.prism = new PrismGeolocalizedInformation();
         this.prism.deserializeAsync(this._prismtree);
      }
   }
}
