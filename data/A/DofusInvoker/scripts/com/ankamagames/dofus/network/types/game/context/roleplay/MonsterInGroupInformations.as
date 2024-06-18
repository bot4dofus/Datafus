package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MonsterInGroupInformations extends MonsterInGroupLightInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7023;
       
      
      public var look:EntityLook;
      
      private var _looktree:FuncTree;
      
      public function MonsterInGroupInformations()
      {
         this.look = new EntityLook();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7023;
      }
      
      public function initMonsterInGroupInformations(genericId:int = 0, grade:uint = 0, level:uint = 0, look:EntityLook = null) : MonsterInGroupInformations
      {
         super.initMonsterInGroupLightInformations(genericId,grade,level);
         this.look = look;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.look = new EntityLook();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MonsterInGroupInformations(output);
      }
      
      public function serializeAs_MonsterInGroupInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_MonsterInGroupLightInformations(output);
         this.look.serializeAs_EntityLook(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MonsterInGroupInformations(input);
      }
      
      public function deserializeAs_MonsterInGroupInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MonsterInGroupInformations(tree);
      }
      
      public function deserializeAsyncAs_MonsterInGroupInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._looktree = tree.addChild(this._looktreeFunc);
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
