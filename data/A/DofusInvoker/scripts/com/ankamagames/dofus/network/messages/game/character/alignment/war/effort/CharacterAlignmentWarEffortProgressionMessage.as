package com.ankamagames.dofus.network.messages.game.character.alignment.war.effort
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterAlignmentWarEffortProgressionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6750;
       
      
      private var _isInitialized:Boolean = false;
      
      public var alignmentWarEffortDailyLimit:Number = 0;
      
      public var alignmentWarEffortDailyDonation:Number = 0;
      
      public var alignmentWarEffortPersonalDonation:Number = 0;
      
      public function CharacterAlignmentWarEffortProgressionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6750;
      }
      
      public function initCharacterAlignmentWarEffortProgressionMessage(alignmentWarEffortDailyLimit:Number = 0, alignmentWarEffortDailyDonation:Number = 0, alignmentWarEffortPersonalDonation:Number = 0) : CharacterAlignmentWarEffortProgressionMessage
      {
         this.alignmentWarEffortDailyLimit = alignmentWarEffortDailyLimit;
         this.alignmentWarEffortDailyDonation = alignmentWarEffortDailyDonation;
         this.alignmentWarEffortPersonalDonation = alignmentWarEffortPersonalDonation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.alignmentWarEffortDailyLimit = 0;
         this.alignmentWarEffortDailyDonation = 0;
         this.alignmentWarEffortPersonalDonation = 0;
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
         this.serializeAs_CharacterAlignmentWarEffortProgressionMessage(output);
      }
      
      public function serializeAs_CharacterAlignmentWarEffortProgressionMessage(output:ICustomDataOutput) : void
      {
         if(this.alignmentWarEffortDailyLimit < 0 || this.alignmentWarEffortDailyLimit > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffortDailyLimit + ") on element alignmentWarEffortDailyLimit.");
         }
         output.writeVarLong(this.alignmentWarEffortDailyLimit);
         if(this.alignmentWarEffortDailyDonation < 0 || this.alignmentWarEffortDailyDonation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffortDailyDonation + ") on element alignmentWarEffortDailyDonation.");
         }
         output.writeVarLong(this.alignmentWarEffortDailyDonation);
         if(this.alignmentWarEffortPersonalDonation < 0 || this.alignmentWarEffortPersonalDonation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffortPersonalDonation + ") on element alignmentWarEffortPersonalDonation.");
         }
         output.writeVarLong(this.alignmentWarEffortPersonalDonation);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterAlignmentWarEffortProgressionMessage(input);
      }
      
      public function deserializeAs_CharacterAlignmentWarEffortProgressionMessage(input:ICustomDataInput) : void
      {
         this._alignmentWarEffortDailyLimitFunc(input);
         this._alignmentWarEffortDailyDonationFunc(input);
         this._alignmentWarEffortPersonalDonationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterAlignmentWarEffortProgressionMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterAlignmentWarEffortProgressionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._alignmentWarEffortDailyLimitFunc);
         tree.addChild(this._alignmentWarEffortDailyDonationFunc);
         tree.addChild(this._alignmentWarEffortPersonalDonationFunc);
      }
      
      private function _alignmentWarEffortDailyLimitFunc(input:ICustomDataInput) : void
      {
         this.alignmentWarEffortDailyLimit = input.readVarUhLong();
         if(this.alignmentWarEffortDailyLimit < 0 || this.alignmentWarEffortDailyLimit > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffortDailyLimit + ") on element of CharacterAlignmentWarEffortProgressionMessage.alignmentWarEffortDailyLimit.");
         }
      }
      
      private function _alignmentWarEffortDailyDonationFunc(input:ICustomDataInput) : void
      {
         this.alignmentWarEffortDailyDonation = input.readVarUhLong();
         if(this.alignmentWarEffortDailyDonation < 0 || this.alignmentWarEffortDailyDonation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffortDailyDonation + ") on element of CharacterAlignmentWarEffortProgressionMessage.alignmentWarEffortDailyDonation.");
         }
      }
      
      private function _alignmentWarEffortPersonalDonationFunc(input:ICustomDataInput) : void
      {
         this.alignmentWarEffortPersonalDonation = input.readVarUhLong();
         if(this.alignmentWarEffortPersonalDonation < 0 || this.alignmentWarEffortPersonalDonation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffortPersonalDonation + ") on element of CharacterAlignmentWarEffortProgressionMessage.alignmentWarEffortPersonalDonation.");
         }
      }
   }
}
