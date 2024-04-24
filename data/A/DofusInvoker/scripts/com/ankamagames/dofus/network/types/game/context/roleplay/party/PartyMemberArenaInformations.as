package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.entity.PartyEntityBaseInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyMemberArenaInformations extends PartyMemberInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8362;
       
      
      public var rank:uint = 0;
      
      public function PartyMemberArenaInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8362;
      }
      
      public function initPartyMemberArenaInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, sex:Boolean = false, lifePoints:uint = 0, maxLifePoints:uint = 0, prospecting:uint = 0, regenRate:uint = 0, initiative:uint = 0, alignmentSide:int = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, status:PlayerStatus = null, entities:Vector.<PartyEntityBaseInformation> = null, rank:uint = 0) : PartyMemberArenaInformations
      {
         super.initPartyMemberInformations(id,name,level,entityLook,breed,sex,lifePoints,maxLifePoints,prospecting,regenRate,initiative,alignmentSide,worldX,worldY,mapId,subAreaId,status,entities);
         this.rank = rank;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.rank = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyMemberArenaInformations(output);
      }
      
      public function serializeAs_PartyMemberArenaInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyMemberInformations(output);
         if(this.rank < 0 || this.rank > 20000)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         output.writeVarShort(this.rank);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyMemberArenaInformations(input);
      }
      
      public function deserializeAs_PartyMemberArenaInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._rankFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyMemberArenaInformations(tree);
      }
      
      public function deserializeAsyncAs_PartyMemberArenaInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._rankFunc);
      }
      
      private function _rankFunc(input:ICustomDataInput) : void
      {
         this.rank = input.readVarUhShort();
         if(this.rank < 0 || this.rank > 20000)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of PartyMemberArenaInformations.rank.");
         }
      }
   }
}
