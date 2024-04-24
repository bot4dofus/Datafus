package com.ankamagames.dofus.network.types.game.guild.logbook.global
{
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildPaddockActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8213;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var paddockCoordinates:MapCoordinatesExtended;
      
      public var farmId:Number = 0;
      
      public var paddockEventType:uint = 0;
      
      private var _paddockCoordinatestree:FuncTree;
      
      public function GuildPaddockActivity()
      {
         this.paddockCoordinates = new MapCoordinatesExtended();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8213;
      }
      
      public function initGuildPaddockActivity(id:uint = 0, date:Number = 0, playerId:Number = 0, playerName:String = "", paddockCoordinates:MapCoordinatesExtended = null, farmId:Number = 0, paddockEventType:uint = 0) : GuildPaddockActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         this.playerId = playerId;
         this.playerName = playerName;
         this.paddockCoordinates = paddockCoordinates;
         this.farmId = farmId;
         this.paddockEventType = paddockEventType;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.paddockCoordinates = new MapCoordinatesExtended();
         this.paddockEventType = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildPaddockActivity(output);
      }
      
      public function serializeAs_GuildPaddockActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         this.paddockCoordinates.serializeAs_MapCoordinatesExtended(output);
         if(this.farmId < 0 || this.farmId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.farmId + ") on element farmId.");
         }
         output.writeDouble(this.farmId);
         output.writeByte(this.paddockEventType);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildPaddockActivity(input);
      }
      
      public function deserializeAs_GuildPaddockActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this.paddockCoordinates = new MapCoordinatesExtended();
         this.paddockCoordinates.deserialize(input);
         this._farmIdFunc(input);
         this._paddockEventTypeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildPaddockActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildPaddockActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         this._paddockCoordinatestree = tree.addChild(this._paddockCoordinatestreeFunc);
         tree.addChild(this._farmIdFunc);
         tree.addChild(this._paddockEventTypeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GuildPaddockActivity.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _paddockCoordinatestreeFunc(input:ICustomDataInput) : void
      {
         this.paddockCoordinates = new MapCoordinatesExtended();
         this.paddockCoordinates.deserializeAsync(this._paddockCoordinatestree);
      }
      
      private function _farmIdFunc(input:ICustomDataInput) : void
      {
         this.farmId = input.readDouble();
         if(this.farmId < 0 || this.farmId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.farmId + ") on element of GuildPaddockActivity.farmId.");
         }
      }
      
      private function _paddockEventTypeFunc(input:ICustomDataInput) : void
      {
         this.paddockEventType = input.readByte();
         if(this.paddockEventType < 0)
         {
            throw new Error("Forbidden value (" + this.paddockEventType + ") on element of GuildPaddockActivity.paddockEventType.");
         }
      }
   }
}
