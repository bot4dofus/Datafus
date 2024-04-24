package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildChestTabContributionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5650;
       
      
      private var _isInitialized:Boolean = false;
      
      public var tabNumber:uint = 0;
      
      public var requiredAmount:Number = 0;
      
      public var currentAmount:Number = 0;
      
      public var chestContributionEnrollmentDelay:Number = 0;
      
      public var chestContributionDelay:Number = 0;
      
      public function GuildChestTabContributionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5650;
      }
      
      public function initGuildChestTabContributionMessage(tabNumber:uint = 0, requiredAmount:Number = 0, currentAmount:Number = 0, chestContributionEnrollmentDelay:Number = 0, chestContributionDelay:Number = 0) : GuildChestTabContributionMessage
      {
         this.tabNumber = tabNumber;
         this.requiredAmount = requiredAmount;
         this.currentAmount = currentAmount;
         this.chestContributionEnrollmentDelay = chestContributionEnrollmentDelay;
         this.chestContributionDelay = chestContributionDelay;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.tabNumber = 0;
         this.requiredAmount = 0;
         this.currentAmount = 0;
         this.chestContributionEnrollmentDelay = 0;
         this.chestContributionDelay = 0;
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
         this.serializeAs_GuildChestTabContributionMessage(output);
      }
      
      public function serializeAs_GuildChestTabContributionMessage(output:ICustomDataOutput) : void
      {
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element tabNumber.");
         }
         output.writeVarInt(this.tabNumber);
         if(this.requiredAmount < 0 || this.requiredAmount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requiredAmount + ") on element requiredAmount.");
         }
         output.writeVarLong(this.requiredAmount);
         if(this.currentAmount < 0 || this.currentAmount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.currentAmount + ") on element currentAmount.");
         }
         output.writeVarLong(this.currentAmount);
         if(this.chestContributionEnrollmentDelay < 0 || this.chestContributionEnrollmentDelay > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.chestContributionEnrollmentDelay + ") on element chestContributionEnrollmentDelay.");
         }
         output.writeDouble(this.chestContributionEnrollmentDelay);
         if(this.chestContributionDelay < 0 || this.chestContributionDelay > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.chestContributionDelay + ") on element chestContributionDelay.");
         }
         output.writeDouble(this.chestContributionDelay);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildChestTabContributionMessage(input);
      }
      
      public function deserializeAs_GuildChestTabContributionMessage(input:ICustomDataInput) : void
      {
         this._tabNumberFunc(input);
         this._requiredAmountFunc(input);
         this._currentAmountFunc(input);
         this._chestContributionEnrollmentDelayFunc(input);
         this._chestContributionDelayFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildChestTabContributionMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildChestTabContributionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._tabNumberFunc);
         tree.addChild(this._requiredAmountFunc);
         tree.addChild(this._currentAmountFunc);
         tree.addChild(this._chestContributionEnrollmentDelayFunc);
         tree.addChild(this._chestContributionDelayFunc);
      }
      
      private function _tabNumberFunc(input:ICustomDataInput) : void
      {
         this.tabNumber = input.readVarUhInt();
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element of GuildChestTabContributionMessage.tabNumber.");
         }
      }
      
      private function _requiredAmountFunc(input:ICustomDataInput) : void
      {
         this.requiredAmount = input.readVarUhLong();
         if(this.requiredAmount < 0 || this.requiredAmount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requiredAmount + ") on element of GuildChestTabContributionMessage.requiredAmount.");
         }
      }
      
      private function _currentAmountFunc(input:ICustomDataInput) : void
      {
         this.currentAmount = input.readVarUhLong();
         if(this.currentAmount < 0 || this.currentAmount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.currentAmount + ") on element of GuildChestTabContributionMessage.currentAmount.");
         }
      }
      
      private function _chestContributionEnrollmentDelayFunc(input:ICustomDataInput) : void
      {
         this.chestContributionEnrollmentDelay = input.readDouble();
         if(this.chestContributionEnrollmentDelay < 0 || this.chestContributionEnrollmentDelay > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.chestContributionEnrollmentDelay + ") on element of GuildChestTabContributionMessage.chestContributionEnrollmentDelay.");
         }
      }
      
      private function _chestContributionDelayFunc(input:ICustomDataInput) : void
      {
         this.chestContributionDelay = input.readDouble();
         if(this.chestContributionDelay < 0 || this.chestContributionDelay > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.chestContributionDelay + ") on element of GuildChestTabContributionMessage.chestContributionDelay.");
         }
      }
   }
}
