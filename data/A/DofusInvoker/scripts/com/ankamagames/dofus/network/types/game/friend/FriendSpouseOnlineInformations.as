package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FriendSpouseOnlineInformations extends FriendSpouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1391;
       
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var inFight:Boolean = false;
      
      public var followSpouse:Boolean = false;
      
      public function FriendSpouseOnlineInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1391;
      }
      
      public function initFriendSpouseOnlineInformations(spouseAccountId:uint = 0, spouseId:Number = 0, spouseName:String = "", spouseLevel:uint = 0, breed:int = 0, sex:int = 0, spouseEntityLook:EntityLook = null, guildInfo:GuildInformations = null, alignmentSide:int = 0, mapId:Number = 0, subAreaId:uint = 0, inFight:Boolean = false, followSpouse:Boolean = false) : FriendSpouseOnlineInformations
      {
         super.initFriendSpouseInformations(spouseAccountId,spouseId,spouseName,spouseLevel,breed,sex,spouseEntityLook,guildInfo,alignmentSide);
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.inFight = inFight;
         this.followSpouse = followSpouse;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.mapId = 0;
         this.subAreaId = 0;
         this.inFight = false;
         this.followSpouse = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FriendSpouseOnlineInformations(output);
      }
      
      public function serializeAs_FriendSpouseOnlineInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FriendSpouseInformations(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.inFight);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.followSpouse);
         output.writeByte(_box0);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendSpouseOnlineInformations(input);
      }
      
      public function deserializeAs_FriendSpouseOnlineInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendSpouseOnlineInformations(tree);
      }
      
      public function deserializeAsyncAs_FriendSpouseOnlineInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.inFight = BooleanByteWrapper.getFlag(_box0,0);
         this.followSpouse = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of FriendSpouseOnlineInformations.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of FriendSpouseOnlineInformations.subAreaId.");
         }
      }
   }
}
