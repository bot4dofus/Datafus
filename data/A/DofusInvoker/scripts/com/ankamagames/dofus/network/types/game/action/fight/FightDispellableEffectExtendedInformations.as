package com.ankamagames.dofus.network.types.game.action.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightDispellableEffectExtendedInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9482;
       
      
      public var actionId:uint = 0;
      
      public var sourceId:Number = 0;
      
      public var effect:AbstractFightDispellableEffect;
      
      private var _effecttree:FuncTree;
      
      public function FightDispellableEffectExtendedInformations()
      {
         this.effect = new AbstractFightDispellableEffect();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9482;
      }
      
      public function initFightDispellableEffectExtendedInformations(actionId:uint = 0, sourceId:Number = 0, effect:AbstractFightDispellableEffect = null) : FightDispellableEffectExtendedInformations
      {
         this.actionId = actionId;
         this.sourceId = sourceId;
         this.effect = effect;
         return this;
      }
      
      public function reset() : void
      {
         this.actionId = 0;
         this.sourceId = 0;
         this.effect = new AbstractFightDispellableEffect();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightDispellableEffectExtendedInformations(output);
      }
      
      public function serializeAs_FightDispellableEffectExtendedInformations(output:ICustomDataOutput) : void
      {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         output.writeVarShort(this.actionId);
         if(this.sourceId < -9007199254740992 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
         }
         output.writeDouble(this.sourceId);
         output.writeShort(this.effect.getTypeId());
         this.effect.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightDispellableEffectExtendedInformations(input);
      }
      
      public function deserializeAs_FightDispellableEffectExtendedInformations(input:ICustomDataInput) : void
      {
         this._actionIdFunc(input);
         this._sourceIdFunc(input);
         var _id3:uint = input.readUnsignedShort();
         this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_id3);
         this.effect.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightDispellableEffectExtendedInformations(tree);
      }
      
      public function deserializeAsyncAs_FightDispellableEffectExtendedInformations(tree:FuncTree) : void
      {
         tree.addChild(this._actionIdFunc);
         tree.addChild(this._sourceIdFunc);
         this._effecttree = tree.addChild(this._effecttreeFunc);
      }
      
      private function _actionIdFunc(input:ICustomDataInput) : void
      {
         this.actionId = input.readVarUhShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of FightDispellableEffectExtendedInformations.actionId.");
         }
      }
      
      private function _sourceIdFunc(input:ICustomDataInput) : void
      {
         this.sourceId = input.readDouble();
         if(this.sourceId < -9007199254740992 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of FightDispellableEffectExtendedInformations.sourceId.");
         }
      }
      
      private function _effecttreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_id);
         this.effect.deserializeAsync(this._effecttree);
      }
   }
}
