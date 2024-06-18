package com.ankamagames.dofus.network.types.game.alliance
{
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.social.SocialMember;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceMemberInfo extends SocialMember implements INetworkType
   {
      
      public static const protocolId:uint = 7753;
       
      
      public var avaRoleId:int = 0;
      
      public function AllianceMemberInfo()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7753;
      }
      
      public function initAllianceMemberInfo(id:Number = 0, name:String = "", level:uint = 0, breed:int = 0, sex:Boolean = false, connected:uint = 99, hoursSinceLastConnection:uint = 0, accountId:uint = 0, status:PlayerStatus = null, rankId:int = 0, enrollmentDate:Number = 0, avaRoleId:int = 0) : AllianceMemberInfo
      {
         super.initSocialMember(id,name,level,breed,sex,connected,hoursSinceLastConnection,accountId,status,rankId,enrollmentDate);
         this.avaRoleId = avaRoleId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.avaRoleId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceMemberInfo(output);
      }
      
      public function serializeAs_AllianceMemberInfo(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialMember(output);
         output.writeInt(this.avaRoleId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMemberInfo(input);
      }
      
      public function deserializeAs_AllianceMemberInfo(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._avaRoleIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceMemberInfo(tree);
      }
      
      public function deserializeAsyncAs_AllianceMemberInfo(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._avaRoleIdFunc);
      }
      
      private function _avaRoleIdFunc(input:ICustomDataInput) : void
      {
         this.avaRoleId = input.readInt();
      }
   }
}
