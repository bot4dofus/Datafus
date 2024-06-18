package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeBonusChoiceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2271;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeBonus:uint = 0;
      
      public function ChallengeBonusChoiceMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2271;
      }
      
      public function initChallengeBonusChoiceMessage(challengeBonus:uint = 0) : ChallengeBonusChoiceMessage
      {
         this.challengeBonus = challengeBonus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeBonus = 0;
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
         this.serializeAs_ChallengeBonusChoiceMessage(output);
      }
      
      public function serializeAs_ChallengeBonusChoiceMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.challengeBonus);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeBonusChoiceMessage(input);
      }
      
      public function deserializeAs_ChallengeBonusChoiceMessage(input:ICustomDataInput) : void
      {
         this._challengeBonusFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeBonusChoiceMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeBonusChoiceMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeBonusFunc);
      }
      
      private function _challengeBonusFunc(input:ICustomDataInput) : void
      {
         this.challengeBonus = input.readByte();
         if(this.challengeBonus < 0)
         {
            throw new Error("Forbidden value (" + this.challengeBonus + ") on element of ChallengeBonusChoiceMessage.challengeBonus.");
         }
      }
   }
}
