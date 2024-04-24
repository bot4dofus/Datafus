package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MimicryObjectFeedAndAssociateRequestMessage extends SymbioticObjectAssociateRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8822;
       
      
      private var _isInitialized:Boolean = false;
      
      public var foodUID:uint = 0;
      
      public var foodPos:uint = 0;
      
      public var preview:Boolean = false;
      
      public function MimicryObjectFeedAndAssociateRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8822;
      }
      
      public function initMimicryObjectFeedAndAssociateRequestMessage(symbioteUID:uint = 0, symbiotePos:uint = 0, hostUID:uint = 0, hostPos:uint = 0, foodUID:uint = 0, foodPos:uint = 0, preview:Boolean = false) : MimicryObjectFeedAndAssociateRequestMessage
      {
         super.initSymbioticObjectAssociateRequestMessage(symbioteUID,symbiotePos,hostUID,hostPos);
         this.foodUID = foodUID;
         this.foodPos = foodPos;
         this.preview = preview;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.foodUID = 0;
         this.foodPos = 0;
         this.preview = false;
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
         this.serializeAs_MimicryObjectFeedAndAssociateRequestMessage(output);
      }
      
      public function serializeAs_MimicryObjectFeedAndAssociateRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SymbioticObjectAssociateRequestMessage(output);
         if(this.foodUID < 0)
         {
            throw new Error("Forbidden value (" + this.foodUID + ") on element foodUID.");
         }
         output.writeVarInt(this.foodUID);
         if(this.foodPos < 0 || this.foodPos > 255)
         {
            throw new Error("Forbidden value (" + this.foodPos + ") on element foodPos.");
         }
         output.writeByte(this.foodPos);
         output.writeBoolean(this.preview);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(input);
      }
      
      public function deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._foodUIDFunc(input);
         this._foodPosFunc(input);
         this._previewFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MimicryObjectFeedAndAssociateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_MimicryObjectFeedAndAssociateRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._foodUIDFunc);
         tree.addChild(this._foodPosFunc);
         tree.addChild(this._previewFunc);
      }
      
      private function _foodUIDFunc(input:ICustomDataInput) : void
      {
         this.foodUID = input.readVarUhInt();
         if(this.foodUID < 0)
         {
            throw new Error("Forbidden value (" + this.foodUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodUID.");
         }
      }
      
      private function _foodPosFunc(input:ICustomDataInput) : void
      {
         this.foodPos = input.readUnsignedByte();
         if(this.foodPos < 0 || this.foodPos > 255)
         {
            throw new Error("Forbidden value (" + this.foodPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodPos.");
         }
      }
      
      private function _previewFunc(input:ICustomDataInput) : void
      {
         this.preview = input.readBoolean();
      }
   }
}
