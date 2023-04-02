package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2375;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeId:uint = 0;
      
      public var targetId:Number = 0;
      
      public var xpBonus:uint = 0;
      
      public var dropBonus:uint = 0;
      
      public function ChallengeInfoMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2375;
      }
      
      public function initChallengeInfoMessage(challengeId:uint = 0, targetId:Number = 0, xpBonus:uint = 0, dropBonus:uint = 0) : ChallengeInfoMessage
      {
         this.challengeId = challengeId;
         this.targetId = targetId;
         this.xpBonus = xpBonus;
         this.dropBonus = dropBonus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeId = 0;
         this.targetId = 0;
         this.xpBonus = 0;
         this.dropBonus = 0;
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
         this.serializeAs_ChallengeInfoMessage(output);
      }
      
      public function serializeAs_ChallengeInfoMessage(output:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         output.writeVarShort(this.challengeId);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.xpBonus < 0)
         {
            throw new Error("Forbidden value (" + this.xpBonus + ") on element xpBonus.");
         }
         output.writeVarInt(this.xpBonus);
         if(this.dropBonus < 0)
         {
            throw new Error("Forbidden value (" + this.dropBonus + ") on element dropBonus.");
         }
         output.writeVarInt(this.dropBonus);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeInfoMessage(input);
      }
      
      public function deserializeAs_ChallengeInfoMessage(input:ICustomDataInput) : void
      {
         this._challengeIdFunc(input);
         this._targetIdFunc(input);
         this._xpBonusFunc(input);
         this._dropBonusFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeInfoMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeInfoMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeIdFunc);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._xpBonusFunc);
         tree.addChild(this._dropBonusFunc);
      }
      
      private function _challengeIdFunc(input:ICustomDataInput) : void
      {
         this.challengeId = input.readVarUhShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeInfoMessage.challengeId.");
         }
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of ChallengeInfoMessage.targetId.");
         }
      }
      
      private function _xpBonusFunc(input:ICustomDataInput) : void
      {
         this.xpBonus = input.readVarUhInt();
         if(this.xpBonus < 0)
         {
            throw new Error("Forbidden value (" + this.xpBonus + ") on element of ChallengeInfoMessage.xpBonus.");
         }
      }
      
      private function _dropBonusFunc(input:ICustomDataInput) : void
      {
         this.dropBonus = input.readVarUhInt();
         if(this.dropBonus < 0)
         {
            throw new Error("Forbidden value (" + this.dropBonus + ") on element of ChallengeInfoMessage.dropBonus.");
         }
      }
   }
}
