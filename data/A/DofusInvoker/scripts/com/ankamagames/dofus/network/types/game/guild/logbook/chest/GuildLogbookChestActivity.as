package com.ankamagames.dofus.network.types.game.guild.logbook.chest
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildLogbookChestActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9067;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var eventType:uint = 0;
      
      public var quantity:uint = 0;
      
      public var object:ObjectItemNotInContainer;
      
      public var sourceTabId:uint = 0;
      
      public var destinationTabId:uint = 0;
      
      private var _objecttree:FuncTree;
      
      public function GuildLogbookChestActivity()
      {
         this.object = new ObjectItemNotInContainer();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9067;
      }
      
      public function initGuildLogbookChestActivity(id:uint = 0, date:Number = 0, playerId:Number = 0, playerName:String = "", eventType:uint = 0, quantity:uint = 0, object:ObjectItemNotInContainer = null, sourceTabId:uint = 0, destinationTabId:uint = 0) : GuildLogbookChestActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         this.playerId = playerId;
         this.playerName = playerName;
         this.eventType = eventType;
         this.quantity = quantity;
         this.object = object;
         this.sourceTabId = sourceTabId;
         this.destinationTabId = destinationTabId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.eventType = 0;
         this.quantity = 0;
         this.object = new ObjectItemNotInContainer();
         this.destinationTabId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildLogbookChestActivity(output);
      }
      
      public function serializeAs_GuildLogbookChestActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         output.writeByte(this.eventType);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeInt(this.quantity);
         this.object.serializeAs_ObjectItemNotInContainer(output);
         if(this.sourceTabId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceTabId + ") on element sourceTabId.");
         }
         output.writeInt(this.sourceTabId);
         if(this.destinationTabId < 0)
         {
            throw new Error("Forbidden value (" + this.destinationTabId + ") on element destinationTabId.");
         }
         output.writeInt(this.destinationTabId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildLogbookChestActivity(input);
      }
      
      public function deserializeAs_GuildLogbookChestActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._eventTypeFunc(input);
         this._quantityFunc(input);
         this.object = new ObjectItemNotInContainer();
         this.object.deserialize(input);
         this._sourceTabIdFunc(input);
         this._destinationTabIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildLogbookChestActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildLogbookChestActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._eventTypeFunc);
         tree.addChild(this._quantityFunc);
         this._objecttree = tree.addChild(this._objecttreeFunc);
         tree.addChild(this._sourceTabIdFunc);
         tree.addChild(this._destinationTabIdFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GuildLogbookChestActivity.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _eventTypeFunc(input:ICustomDataInput) : void
      {
         this.eventType = input.readByte();
         if(this.eventType < 0)
         {
            throw new Error("Forbidden value (" + this.eventType + ") on element of GuildLogbookChestActivity.eventType.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of GuildLogbookChestActivity.quantity.");
         }
      }
      
      private function _objecttreeFunc(input:ICustomDataInput) : void
      {
         this.object = new ObjectItemNotInContainer();
         this.object.deserializeAsync(this._objecttree);
      }
      
      private function _sourceTabIdFunc(input:ICustomDataInput) : void
      {
         this.sourceTabId = input.readInt();
         if(this.sourceTabId < 0)
         {
            throw new Error("Forbidden value (" + this.sourceTabId + ") on element of GuildLogbookChestActivity.sourceTabId.");
         }
      }
      
      private function _destinationTabIdFunc(input:ICustomDataInput) : void
      {
         this.destinationTabId = input.readInt();
         if(this.destinationTabId < 0)
         {
            throw new Error("Forbidden value (" + this.destinationTabId + ") on element of GuildLogbookChestActivity.destinationTabId.");
         }
      }
   }
}
