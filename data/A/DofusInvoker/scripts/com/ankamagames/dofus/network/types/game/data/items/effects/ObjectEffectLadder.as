package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectLadder extends ObjectEffectCreature implements INetworkType
   {
      
      public static const protocolId:uint = 5489;
       
      
      public var monsterCount:uint = 0;
      
      public function ObjectEffectLadder()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5489;
      }
      
      public function initObjectEffectLadder(actionId:uint = 0, monsterFamilyId:uint = 0, monsterCount:uint = 0) : ObjectEffectLadder
      {
         super.initObjectEffectCreature(actionId,monsterFamilyId);
         this.monsterCount = monsterCount;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.monsterCount = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectLadder(output);
      }
      
      public function serializeAs_ObjectEffectLadder(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffectCreature(output);
         if(this.monsterCount < 0)
         {
            throw new Error("Forbidden value (" + this.monsterCount + ") on element monsterCount.");
         }
         output.writeVarInt(this.monsterCount);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectLadder(input);
      }
      
      public function deserializeAs_ObjectEffectLadder(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._monsterCountFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectLadder(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectLadder(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._monsterCountFunc);
      }
      
      private function _monsterCountFunc(input:ICustomDataInput) : void
      {
         this.monsterCount = input.readVarUhInt();
         if(this.monsterCount < 0)
         {
            throw new Error("Forbidden value (" + this.monsterCount + ") on element of ObjectEffectLadder.monsterCount.");
         }
      }
   }
}
