package com.ankamagames.dofus.network.messages.game.nuggets
{
   import com.ankamagames.dofus.network.types.game.nuggets.NuggetsBeneficiary;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NuggetsDistributionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7391;
       
      
      private var _isInitialized:Boolean = false;
      
      public var beneficiaries:Vector.<NuggetsBeneficiary>;
      
      private var _beneficiariestree:FuncTree;
      
      public function NuggetsDistributionMessage()
      {
         this.beneficiaries = new Vector.<NuggetsBeneficiary>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7391;
      }
      
      public function initNuggetsDistributionMessage(beneficiaries:Vector.<NuggetsBeneficiary> = null) : NuggetsDistributionMessage
      {
         this.beneficiaries = beneficiaries;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.beneficiaries = new Vector.<NuggetsBeneficiary>();
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
         this.serializeAs_NuggetsDistributionMessage(output);
      }
      
      public function serializeAs_NuggetsDistributionMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.beneficiaries.length);
         for(var _i1:uint = 0; _i1 < this.beneficiaries.length; _i1++)
         {
            (this.beneficiaries[_i1] as NuggetsBeneficiary).serializeAs_NuggetsBeneficiary(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NuggetsDistributionMessage(input);
      }
      
      public function deserializeAs_NuggetsDistributionMessage(input:ICustomDataInput) : void
      {
         var _item1:NuggetsBeneficiary = null;
         var _beneficiariesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _beneficiariesLen; _i1++)
         {
            _item1 = new NuggetsBeneficiary();
            _item1.deserialize(input);
            this.beneficiaries.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NuggetsDistributionMessage(tree);
      }
      
      public function deserializeAsyncAs_NuggetsDistributionMessage(tree:FuncTree) : void
      {
         this._beneficiariestree = tree.addChild(this._beneficiariestreeFunc);
      }
      
      private function _beneficiariestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._beneficiariestree.addChild(this._beneficiariesFunc);
         }
      }
      
      private function _beneficiariesFunc(input:ICustomDataInput) : void
      {
         var _item:NuggetsBeneficiary = new NuggetsBeneficiary();
         _item.deserialize(input);
         this.beneficiaries.push(_item);
      }
   }
}
