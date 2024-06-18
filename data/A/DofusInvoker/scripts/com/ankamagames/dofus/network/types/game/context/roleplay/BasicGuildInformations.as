package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BasicGuildInformations extends AbstractSocialGroupInfos implements INetworkType
   {
      
      public static const protocolId:uint = 4606;
       
      
      public var guildId:uint = 0;
      
      public var guildName:String = "";
      
      public var guildLevel:uint = 0;
      
      public function BasicGuildInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4606;
      }
      
      public function initBasicGuildInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0) : BasicGuildInformations
      {
         this.guildId = guildId;
         this.guildName = guildName;
         this.guildLevel = guildLevel;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildId = 0;
         this.guildName = "";
         this.guildLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BasicGuildInformations(output);
      }
      
      public function serializeAs_BasicGuildInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractSocialGroupInfos(output);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
         output.writeUTF(this.guildName);
         if(this.guildLevel < 0 || this.guildLevel > 200)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         output.writeByte(this.guildLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicGuildInformations(input);
      }
      
      public function deserializeAs_BasicGuildInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._guildIdFunc(input);
         this._guildNameFunc(input);
         this._guildLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicGuildInformations(tree);
      }
      
      public function deserializeAsyncAs_BasicGuildInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._guildIdFunc);
         tree.addChild(this._guildNameFunc);
         tree.addChild(this._guildLevelFunc);
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of BasicGuildInformations.guildId.");
         }
      }
      
      private function _guildNameFunc(input:ICustomDataInput) : void
      {
         this.guildName = input.readUTF();
      }
      
      private function _guildLevelFunc(input:ICustomDataInput) : void
      {
         this.guildLevel = input.readUnsignedByte();
         if(this.guildLevel < 0 || this.guildLevel > 200)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of BasicGuildInformations.guildLevel.");
         }
      }
   }
}
