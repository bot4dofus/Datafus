package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseGuildedInformations extends HouseInstanceInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4071;
       
      
      public var guildInfo:GuildInformations;
      
      private var _guildInfotree:FuncTree;
      
      public function HouseGuildedInformations()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4071;
      }
      
      public function initHouseGuildedInformations(instanceId:uint = 0, secondHand:Boolean = false, isLocked:Boolean = false, ownerTag:AccountTagInformation = null, hasOwner:Boolean = false, price:Number = 0, isSaleLocked:Boolean = false, isAdminLocked:Boolean = false, guildInfo:GuildInformations = null) : HouseGuildedInformations
      {
         super.initHouseInstanceInformations(instanceId,secondHand,isLocked,ownerTag,hasOwner,price,isSaleLocked,isAdminLocked);
         this.guildInfo = guildInfo;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guildInfo = new GuildInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseGuildedInformations(output);
      }
      
      public function serializeAs_HouseGuildedInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_HouseInstanceInformations(output);
         this.guildInfo.serializeAs_GuildInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseGuildedInformations(input);
      }
      
      public function deserializeAs_HouseGuildedInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseGuildedInformations(tree);
      }
      
      public function deserializeAsyncAs_HouseGuildedInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
   }
}
