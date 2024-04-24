package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightEffectTriggerCount implements INetworkType
   {
      
      public static const protocolId:uint = 7944;
       
      
      public var effectId:uint = 0;
      
      public var targetId:Number = 0;
      
      public var count:uint = 0;
      
      public function GameFightEffectTriggerCount()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7944;
      }
      
      public function initGameFightEffectTriggerCount(effectId:uint = 0, targetId:Number = 0, count:uint = 0) : GameFightEffectTriggerCount
      {
         this.effectId = effectId;
         this.targetId = targetId;
         this.count = count;
         return this;
      }
      
      public function reset() : void
      {
         this.effectId = 0;
         this.targetId = 0;
         this.count = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightEffectTriggerCount(output);
      }
      
      public function serializeAs_GameFightEffectTriggerCount(output:ICustomDataOutput) : void
      {
         if(this.effectId < 0)
         {
            throw new Error("Forbidden value (" + this.effectId + ") on element effectId.");
         }
         output.writeVarInt(this.effectId);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.count < 0)
         {
            throw new Error("Forbidden value (" + this.count + ") on element count.");
         }
         output.writeShort(this.count);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightEffectTriggerCount(input);
      }
      
      public function deserializeAs_GameFightEffectTriggerCount(input:ICustomDataInput) : void
      {
         this._effectIdFunc(input);
         this._targetIdFunc(input);
         this._countFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightEffectTriggerCount(tree);
      }
      
      public function deserializeAsyncAs_GameFightEffectTriggerCount(tree:FuncTree) : void
      {
         tree.addChild(this._effectIdFunc);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._countFunc);
      }
      
      private function _effectIdFunc(input:ICustomDataInput) : void
      {
         this.effectId = input.readVarUhInt();
         if(this.effectId < 0)
         {
            throw new Error("Forbidden value (" + this.effectId + ") on element of GameFightEffectTriggerCount.effectId.");
         }
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameFightEffectTriggerCount.targetId.");
         }
      }
      
      private function _countFunc(input:ICustomDataInput) : void
      {
         this.count = input.readShort();
         if(this.count < 0)
         {
            throw new Error("Forbidden value (" + this.count + ") on element of GameFightEffectTriggerCount.count.");
         }
      }
   }
}
