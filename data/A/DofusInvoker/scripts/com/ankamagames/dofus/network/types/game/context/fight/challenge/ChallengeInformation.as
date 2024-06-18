package com.ankamagames.dofus.network.types.game.context.fight.challenge
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ChallengeInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1494;
       
      
      public var challengeId:uint = 0;
      
      public var targetsList:Vector.<ChallengeTargetInformation>;
      
      public var dropBonus:uint = 0;
      
      public var xpBonus:uint = 0;
      
      public var state:uint = 2;
      
      private var _targetsListtree:FuncTree;
      
      public function ChallengeInformation()
      {
         this.targetsList = new Vector.<ChallengeTargetInformation>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1494;
      }
      
      public function initChallengeInformation(challengeId:uint = 0, targetsList:Vector.<ChallengeTargetInformation> = null, dropBonus:uint = 0, xpBonus:uint = 0, state:uint = 2) : ChallengeInformation
      {
         this.challengeId = challengeId;
         this.targetsList = targetsList;
         this.dropBonus = dropBonus;
         this.xpBonus = xpBonus;
         this.state = state;
         return this;
      }
      
      public function reset() : void
      {
         this.challengeId = 0;
         this.targetsList = new Vector.<ChallengeTargetInformation>();
         this.dropBonus = 0;
         this.xpBonus = 0;
         this.state = 2;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ChallengeInformation(output);
      }
      
      public function serializeAs_ChallengeInformation(output:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         output.writeVarInt(this.challengeId);
         output.writeShort(this.targetsList.length);
         for(var _i2:uint = 0; _i2 < this.targetsList.length; _i2++)
         {
            output.writeShort((this.targetsList[_i2] as ChallengeTargetInformation).getTypeId());
            (this.targetsList[_i2] as ChallengeTargetInformation).serialize(output);
         }
         if(this.dropBonus < 0)
         {
            throw new Error("Forbidden value (" + this.dropBonus + ") on element dropBonus.");
         }
         output.writeVarInt(this.dropBonus);
         if(this.xpBonus < 0)
         {
            throw new Error("Forbidden value (" + this.xpBonus + ") on element xpBonus.");
         }
         output.writeVarInt(this.xpBonus);
         output.writeByte(this.state);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeInformation(input);
      }
      
      public function deserializeAs_ChallengeInformation(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:ChallengeTargetInformation = null;
         this._challengeIdFunc(input);
         var _targetsListLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _targetsListLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(ChallengeTargetInformation,_id2);
            _item2.deserialize(input);
            this.targetsList.push(_item2);
         }
         this._dropBonusFunc(input);
         this._xpBonusFunc(input);
         this._stateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeInformation(tree);
      }
      
      public function deserializeAsyncAs_ChallengeInformation(tree:FuncTree) : void
      {
         tree.addChild(this._challengeIdFunc);
         this._targetsListtree = tree.addChild(this._targetsListtreeFunc);
         tree.addChild(this._dropBonusFunc);
         tree.addChild(this._xpBonusFunc);
         tree.addChild(this._stateFunc);
      }
      
      private function _challengeIdFunc(input:ICustomDataInput) : void
      {
         this.challengeId = input.readVarUhInt();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeInformation.challengeId.");
         }
      }
      
      private function _targetsListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._targetsListtree.addChild(this._targetsListFunc);
         }
      }
      
      private function _targetsListFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ChallengeTargetInformation = ProtocolTypeManager.getInstance(ChallengeTargetInformation,_id);
         _item.deserialize(input);
         this.targetsList.push(_item);
      }
      
      private function _dropBonusFunc(input:ICustomDataInput) : void
      {
         this.dropBonus = input.readVarUhInt();
         if(this.dropBonus < 0)
         {
            throw new Error("Forbidden value (" + this.dropBonus + ") on element of ChallengeInformation.dropBonus.");
         }
      }
      
      private function _xpBonusFunc(input:ICustomDataInput) : void
      {
         this.xpBonus = input.readVarUhInt();
         if(this.xpBonus < 0)
         {
            throw new Error("Forbidden value (" + this.xpBonus + ") on element of ChallengeInformation.xpBonus.");
         }
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of ChallengeInformation.state.");
         }
      }
   }
}
