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
   
   public class PrismAttackResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8541;
       
      
      private var _isInitialized:Boolean = false;
      
      public var prism:PrismGeolocalizedInformation;
      
      public var result:uint = 0;
      
      private var _prismtree:FuncTree;
      
      public function PrismAttackResultMessage()
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
         return 8541;
      }
      
      public function initPrismAttackResultMessage(prism:PrismGeolocalizedInformation = null, result:uint = 0) : PrismAttackResultMessage
      {
         this.prism = prism;
         this.result = result;
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
         this.serializeAs_PrismAttackResultMessage(output);
      }
      
      public function serializeAs_PrismAttackResultMessage(output:ICustomDataOutput) : void
      {
         this.prism.serializeAs_PrismGeolocalizedInformation(output);
         output.writeByte(this.result);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismAttackResultMessage(input);
      }
      
      public function deserializeAs_PrismAttackResultMessage(input:ICustomDataInput) : void
      {
         this.prism = new PrismGeolocalizedInformation();
         this.prism.deserialize(input);
         this._resultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismAttackResultMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismAttackResultMessage(tree:FuncTree) : void
      {
         this._prismtree = tree.addChild(this._prismtreeFunc);
         tree.addChild(this._resultFunc);
      }
      
      private function _prismtreeFunc(input:ICustomDataInput) : void
      {
         this.prism = new PrismGeolocalizedInformation();
         this.prism.deserializeAsync(this._prismtree);
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of PrismAttackResultMessage.result.");
         }
      }
   }
}
