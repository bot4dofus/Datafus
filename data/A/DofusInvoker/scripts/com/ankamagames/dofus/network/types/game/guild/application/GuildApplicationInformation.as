package com.ankamagames.dofus.network.types.game.guild.application
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildApplicationInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8441;
       
      
      public var playerInfo:ApplicationPlayerInformation;
      
      public var applyText:String = "";
      
      public var creationDate:Number = 0;
      
      private var _playerInfotree:FuncTree;
      
      public function GuildApplicationInformation()
      {
         this.playerInfo = new ApplicationPlayerInformation();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8441;
      }
      
      public function initGuildApplicationInformation(playerInfo:ApplicationPlayerInformation = null, applyText:String = "", creationDate:Number = 0) : GuildApplicationInformation
      {
         this.playerInfo = playerInfo;
         this.applyText = applyText;
         this.creationDate = creationDate;
         return this;
      }
      
      public function reset() : void
      {
         this.playerInfo = new ApplicationPlayerInformation();
         this.creationDate = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildApplicationInformation(output);
      }
      
      public function serializeAs_GuildApplicationInformation(output:ICustomDataOutput) : void
      {
         this.playerInfo.serializeAs_ApplicationPlayerInformation(output);
         output.writeUTF(this.applyText);
         if(this.creationDate < -9007199254740992 || this.creationDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         output.writeDouble(this.creationDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildApplicationInformation(input);
      }
      
      public function deserializeAs_GuildApplicationInformation(input:ICustomDataInput) : void
      {
         this.playerInfo = new ApplicationPlayerInformation();
         this.playerInfo.deserialize(input);
         this._applyTextFunc(input);
         this._creationDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildApplicationInformation(tree);
      }
      
      public function deserializeAsyncAs_GuildApplicationInformation(tree:FuncTree) : void
      {
         this._playerInfotree = tree.addChild(this._playerInfotreeFunc);
         tree.addChild(this._applyTextFunc);
         tree.addChild(this._creationDateFunc);
      }
      
      private function _playerInfotreeFunc(input:ICustomDataInput) : void
      {
         this.playerInfo = new ApplicationPlayerInformation();
         this.playerInfo.deserializeAsync(this._playerInfotree);
      }
      
      private function _applyTextFunc(input:ICustomDataInput) : void
      {
         this.applyText = input.readUTF();
      }
      
      private function _creationDateFunc(input:ICustomDataInput) : void
      {
         this.creationDate = input.readDouble();
         if(this.creationDate < -9007199254740992 || this.creationDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildApplicationInformation.creationDate.");
         }
      }
   }
}
