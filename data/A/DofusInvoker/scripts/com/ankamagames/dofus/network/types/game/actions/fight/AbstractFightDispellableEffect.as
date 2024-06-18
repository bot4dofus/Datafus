package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AbstractFightDispellableEffect implements INetworkType
   {
      
      public static const protocolId:uint = 4079;
       
      
      public var uid:uint = 0;
      
      public var targetId:Number = 0;
      
      public var turnDuration:int = 0;
      
      public var dispelable:uint = 1;
      
      public var spellId:uint = 0;
      
      public var effectId:uint = 0;
      
      public var parentBoostUid:uint = 0;
      
      public function AbstractFightDispellableEffect()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4079;
      }
      
      public function initAbstractFightDispellableEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0) : AbstractFightDispellableEffect
      {
         this.uid = uid;
         this.targetId = targetId;
         this.turnDuration = turnDuration;
         this.dispelable = dispelable;
         this.spellId = spellId;
         this.effectId = effectId;
         this.parentBoostUid = parentBoostUid;
         return this;
      }
      
      public function reset() : void
      {
         this.uid = 0;
         this.targetId = 0;
         this.turnDuration = 0;
         this.dispelable = 1;
         this.spellId = 0;
         this.effectId = 0;
         this.parentBoostUid = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractFightDispellableEffect(output);
      }
      
      public function serializeAs_AbstractFightDispellableEffect(output:ICustomDataOutput) : void
      {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         output.writeVarInt(this.uid);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         output.writeShort(this.turnDuration);
         output.writeByte(this.dispelable);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         if(this.effectId < 0)
         {
            throw new Error("Forbidden value (" + this.effectId + ") on element effectId.");
         }
         output.writeVarInt(this.effectId);
         if(this.parentBoostUid < 0)
         {
            throw new Error("Forbidden value (" + this.parentBoostUid + ") on element parentBoostUid.");
         }
         output.writeVarInt(this.parentBoostUid);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractFightDispellableEffect(input);
      }
      
      public function deserializeAs_AbstractFightDispellableEffect(input:ICustomDataInput) : void
      {
         this._uidFunc(input);
         this._targetIdFunc(input);
         this._turnDurationFunc(input);
         this._dispelableFunc(input);
         this._spellIdFunc(input);
         this._effectIdFunc(input);
         this._parentBoostUidFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractFightDispellableEffect(tree);
      }
      
      public function deserializeAsyncAs_AbstractFightDispellableEffect(tree:FuncTree) : void
      {
         tree.addChild(this._uidFunc);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._turnDurationFunc);
         tree.addChild(this._dispelableFunc);
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._effectIdFunc);
         tree.addChild(this._parentBoostUidFunc);
      }
      
      private function _uidFunc(input:ICustomDataInput) : void
      {
         this.uid = input.readVarUhInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of AbstractFightDispellableEffect.uid.");
         }
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of AbstractFightDispellableEffect.targetId.");
         }
      }
      
      private function _turnDurationFunc(input:ICustomDataInput) : void
      {
         this.turnDuration = input.readShort();
      }
      
      private function _dispelableFunc(input:ICustomDataInput) : void
      {
         this.dispelable = input.readByte();
         if(this.dispelable < 0)
         {
            throw new Error("Forbidden value (" + this.dispelable + ") on element of AbstractFightDispellableEffect.dispelable.");
         }
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of AbstractFightDispellableEffect.spellId.");
         }
      }
      
      private function _effectIdFunc(input:ICustomDataInput) : void
      {
         this.effectId = input.readVarUhInt();
         if(this.effectId < 0)
         {
            throw new Error("Forbidden value (" + this.effectId + ") on element of AbstractFightDispellableEffect.effectId.");
         }
      }
      
      private function _parentBoostUidFunc(input:ICustomDataInput) : void
      {
         this.parentBoostUid = input.readVarUhInt();
         if(this.parentBoostUid < 0)
         {
            throw new Error("Forbidden value (" + this.parentBoostUid + ") on element of AbstractFightDispellableEffect.parentBoostUid.");
         }
      }
   }
}
