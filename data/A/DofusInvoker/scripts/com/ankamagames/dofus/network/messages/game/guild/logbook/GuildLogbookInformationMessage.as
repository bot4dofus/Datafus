package com.ankamagames.dofus.network.messages.game.guild.logbook
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildLogbookInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8089;
       
      
      private var _isInitialized:Boolean = false;
      
      public var globalActivities:Vector.<GuildLogbookEntryBasicInformation>;
      
      public var chestActivities:Vector.<GuildLogbookEntryBasicInformation>;
      
      private var _globalActivitiestree:FuncTree;
      
      private var _chestActivitiestree:FuncTree;
      
      public function GuildLogbookInformationMessage()
      {
         this.globalActivities = new Vector.<GuildLogbookEntryBasicInformation>();
         this.chestActivities = new Vector.<GuildLogbookEntryBasicInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8089;
      }
      
      public function initGuildLogbookInformationMessage(globalActivities:Vector.<GuildLogbookEntryBasicInformation> = null, chestActivities:Vector.<GuildLogbookEntryBasicInformation> = null) : GuildLogbookInformationMessage
      {
         this.globalActivities = globalActivities;
         this.chestActivities = chestActivities;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.globalActivities = new Vector.<GuildLogbookEntryBasicInformation>();
         this.chestActivities = new Vector.<GuildLogbookEntryBasicInformation>();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildLogbookInformationMessage(output);
      }
      
      public function serializeAs_GuildLogbookInformationMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.globalActivities.length);
         for(var _i1:uint = 0; _i1 < this.globalActivities.length; _i1++)
         {
            output.writeShort((this.globalActivities[_i1] as GuildLogbookEntryBasicInformation).getTypeId());
            (this.globalActivities[_i1] as GuildLogbookEntryBasicInformation).serialize(output);
         }
         output.writeShort(this.chestActivities.length);
         for(var _i2:uint = 0; _i2 < this.chestActivities.length; _i2++)
         {
            output.writeShort((this.chestActivities[_i2] as GuildLogbookEntryBasicInformation).getTypeId());
            (this.chestActivities[_i2] as GuildLogbookEntryBasicInformation).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildLogbookInformationMessage(input);
      }
      
      public function deserializeAs_GuildLogbookInformationMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:GuildLogbookEntryBasicInformation = null;
         var _id2:uint = 0;
         var _item2:GuildLogbookEntryBasicInformation = null;
         var _globalActivitiesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _globalActivitiesLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(GuildLogbookEntryBasicInformation,_id1);
            _item1.deserialize(input);
            this.globalActivities.push(_item1);
         }
         var _chestActivitiesLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _chestActivitiesLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(GuildLogbookEntryBasicInformation,_id2);
            _item2.deserialize(input);
            this.chestActivities.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildLogbookInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildLogbookInformationMessage(tree:FuncTree) : void
      {
         this._globalActivitiestree = tree.addChild(this._globalActivitiestreeFunc);
         this._chestActivitiestree = tree.addChild(this._chestActivitiestreeFunc);
      }
      
      private function _globalActivitiestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._globalActivitiestree.addChild(this._globalActivitiesFunc);
         }
      }
      
      private function _globalActivitiesFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GuildLogbookEntryBasicInformation = ProtocolTypeManager.getInstance(GuildLogbookEntryBasicInformation,_id);
         _item.deserialize(input);
         this.globalActivities.push(_item);
      }
      
      private function _chestActivitiestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._chestActivitiestree.addChild(this._chestActivitiesFunc);
         }
      }
      
      private function _chestActivitiesFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GuildLogbookEntryBasicInformation = ProtocolTypeManager.getInstance(GuildLogbookEntryBasicInformation,_id);
         _item.deserialize(input);
         this.chestActivities.push(_item);
      }
   }
}
