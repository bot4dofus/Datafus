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
   
   public class PrismRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4672;
       
      
      private var _isInitialized:Boolean = false;
      
      public var prism:PrismGeolocalizedInformation;
      
      private var _prismtree:FuncTree;
      
      public function PrismRemoveMessage()
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
         return 4672;
      }
      
      public function initPrismRemoveMessage(prism:PrismGeolocalizedInformation = null) : PrismRemoveMessage
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
         this.serializeAs_PrismRemoveMessage(output);
      }
      
      public function serializeAs_PrismRemoveMessage(output:ICustomDataOutput) : void
      {
         this.prism.serializeAs_PrismGeolocalizedInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismRemoveMessage(input);
      }
      
      public function deserializeAs_PrismRemoveMessage(input:ICustomDataInput) : void
      {
         this.prism = new PrismGeolocalizedInformation();
         this.prism.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismRemoveMessage(tree:FuncTree) : void
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
