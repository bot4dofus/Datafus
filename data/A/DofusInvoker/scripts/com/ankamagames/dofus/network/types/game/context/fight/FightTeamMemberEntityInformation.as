package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamMemberEntityInformation extends FightTeamMemberInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5854;
       
      
      public var entityModelId:uint = 0;
      
      public var level:uint = 0;
      
      public var masterId:Number = 0;
      
      public function FightTeamMemberEntityInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5854;
      }
      
      public function initFightTeamMemberEntityInformation(id:Number = 0, entityModelId:uint = 0, level:uint = 0, masterId:Number = 0) : FightTeamMemberEntityInformation
      {
         super.initFightTeamMemberInformations(id);
         this.entityModelId = entityModelId;
         this.level = level;
         this.masterId = masterId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.entityModelId = 0;
         this.level = 0;
         this.masterId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberEntityInformation(output);
      }
      
      public function serializeAs_FightTeamMemberEntityInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberInformations(output);
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element entityModelId.");
         }
         output.writeByte(this.entityModelId);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element masterId.");
         }
         output.writeDouble(this.masterId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberEntityInformation(input);
      }
      
      public function deserializeAs_FightTeamMemberEntityInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._entityModelIdFunc(input);
         this._levelFunc(input);
         this._masterIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamMemberEntityInformation(tree);
      }
      
      public function deserializeAsyncAs_FightTeamMemberEntityInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._entityModelIdFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._masterIdFunc);
      }
      
      private function _entityModelIdFunc(input:ICustomDataInput) : void
      {
         this.entityModelId = input.readByte();
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element of FightTeamMemberEntityInformation.entityModelId.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberEntityInformation.level.");
         }
      }
      
      private function _masterIdFunc(input:ICustomDataInput) : void
      {
         this.masterId = input.readDouble();
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element of FightTeamMemberEntityInformation.masterId.");
         }
      }
   }
}
