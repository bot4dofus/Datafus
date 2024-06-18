package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class IgnoredOnlineInformations extends IgnoredInformations implements INetworkType
   {
      
      public static const protocolId:uint = 941;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public function IgnoredOnlineInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 941;
      }
      
      public function initIgnoredOnlineInformations(accountId:uint = 0, accountTag:AccountTagInformation = null, playerId:Number = 0, playerName:String = "", breed:int = 0, sex:Boolean = false) : IgnoredOnlineInformations
      {
         super.initIgnoredInformations(accountId,accountTag);
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IgnoredOnlineInformations(output);
      }
      
      public function serializeAs_IgnoredOnlineInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_IgnoredInformations(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredOnlineInformations(input);
      }
      
      public function deserializeAs_IgnoredOnlineInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IgnoredOnlineInformations(tree);
      }
      
      public function deserializeAsyncAs_IgnoredOnlineInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of IgnoredOnlineInformations.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
         if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Forgelance)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of IgnoredOnlineInformations.breed.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
   }
}
