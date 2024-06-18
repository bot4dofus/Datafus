package com.ankamagames.dofus.network.types.game.social.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SocialFightInfo implements INetworkType
   {
      
      public static const protocolId:uint = 2355;
       
      
      public var fightId:uint = 0;
      
      public var fightType:uint = 0;
      
      public var mapId:Number = 0;
      
      public function SocialFightInfo()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2355;
      }
      
      public function initSocialFightInfo(fightId:uint = 0, fightType:uint = 0, mapId:Number = 0) : SocialFightInfo
      {
         this.fightId = fightId;
         this.fightType = fightType;
         this.mapId = mapId;
         return this;
      }
      
      public function reset() : void
      {
         this.fightId = 0;
         this.fightType = 0;
         this.mapId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SocialFightInfo(output);
      }
      
      public function serializeAs_SocialFightInfo(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeByte(this.fightType);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialFightInfo(input);
      }
      
      public function deserializeAs_SocialFightInfo(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._fightTypeFunc(input);
         this._mapIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialFightInfo(tree);
      }
      
      public function deserializeAsyncAs_SocialFightInfo(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._fightTypeFunc);
         tree.addChild(this._mapIdFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of SocialFightInfo.fightId.");
         }
      }
      
      private function _fightTypeFunc(input:ICustomDataInput) : void
      {
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of SocialFightInfo.fightType.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of SocialFightInfo.mapId.");
         }
      }
   }
}
