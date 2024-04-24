package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MonsterBoosts implements INetworkType
   {
      
      public static const protocolId:uint = 84;
       
      
      public var id:uint = 0;
      
      public var xpBoost:uint = 0;
      
      public var dropBoost:uint = 0;
      
      public function MonsterBoosts()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 84;
      }
      
      public function initMonsterBoosts(id:uint = 0, xpBoost:uint = 0, dropBoost:uint = 0) : MonsterBoosts
      {
         this.id = id;
         this.xpBoost = xpBoost;
         this.dropBoost = dropBoost;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.xpBoost = 0;
         this.dropBoost = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MonsterBoosts(output);
      }
      
      public function serializeAs_MonsterBoosts(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         if(this.xpBoost < 0)
         {
            throw new Error("Forbidden value (" + this.xpBoost + ") on element xpBoost.");
         }
         output.writeVarShort(this.xpBoost);
         if(this.dropBoost < 0)
         {
            throw new Error("Forbidden value (" + this.dropBoost + ") on element dropBoost.");
         }
         output.writeVarShort(this.dropBoost);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MonsterBoosts(input);
      }
      
      public function deserializeAs_MonsterBoosts(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._xpBoostFunc(input);
         this._dropBoostFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MonsterBoosts(tree);
      }
      
      public function deserializeAsyncAs_MonsterBoosts(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._xpBoostFunc);
         tree.addChild(this._dropBoostFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of MonsterBoosts.id.");
         }
      }
      
      private function _xpBoostFunc(input:ICustomDataInput) : void
      {
         this.xpBoost = input.readVarUhShort();
         if(this.xpBoost < 0)
         {
            throw new Error("Forbidden value (" + this.xpBoost + ") on element of MonsterBoosts.xpBoost.");
         }
      }
      
      private function _dropBoostFunc(input:ICustomDataInput) : void
      {
         this.dropBoost = input.readVarUhShort();
         if(this.dropBoost < 0)
         {
            throw new Error("Forbidden value (" + this.dropBoost + ") on element of MonsterBoosts.dropBoost.");
         }
      }
   }
}
