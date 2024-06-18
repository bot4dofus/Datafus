package com.ankamagames.dofus.network.types.game.alliance
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class KohAllianceRoleMembers implements INetworkType
   {
      
      public static const protocolId:uint = 9987;
       
      
      public var memberCount:Number = 0;
      
      public var roleAvAId:int = 0;
      
      public function KohAllianceRoleMembers()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9987;
      }
      
      public function initKohAllianceRoleMembers(memberCount:Number = 0, roleAvAId:int = 0) : KohAllianceRoleMembers
      {
         this.memberCount = memberCount;
         this.roleAvAId = roleAvAId;
         return this;
      }
      
      public function reset() : void
      {
         this.memberCount = 0;
         this.roleAvAId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_KohAllianceRoleMembers(output);
      }
      
      public function serializeAs_KohAllianceRoleMembers(output:ICustomDataOutput) : void
      {
         if(this.memberCount < 0 || this.memberCount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberCount + ") on element memberCount.");
         }
         output.writeVarLong(this.memberCount);
         output.writeInt(this.roleAvAId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KohAllianceRoleMembers(input);
      }
      
      public function deserializeAs_KohAllianceRoleMembers(input:ICustomDataInput) : void
      {
         this._memberCountFunc(input);
         this._roleAvAIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KohAllianceRoleMembers(tree);
      }
      
      public function deserializeAsyncAs_KohAllianceRoleMembers(tree:FuncTree) : void
      {
         tree.addChild(this._memberCountFunc);
         tree.addChild(this._roleAvAIdFunc);
      }
      
      private function _memberCountFunc(input:ICustomDataInput) : void
      {
         this.memberCount = input.readVarUhLong();
         if(this.memberCount < 0 || this.memberCount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberCount + ") on element of KohAllianceRoleMembers.memberCount.");
         }
      }
      
      private function _roleAvAIdFunc(input:ICustomDataInput) : void
      {
         this.roleAvAId = input.readInt();
      }
   }
}
