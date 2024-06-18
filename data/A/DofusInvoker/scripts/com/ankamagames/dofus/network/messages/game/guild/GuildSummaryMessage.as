package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.PaginationAnswerAbstractMessage;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildSummaryMessage extends PaginationAnswerAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 156;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guilds:Vector.<GuildFactSheetInformations>;
      
      private var _guildstree:FuncTree;
      
      public function GuildSummaryMessage()
      {
         this.guilds = new Vector.<GuildFactSheetInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 156;
      }
      
      public function initGuildSummaryMessage(offset:Number = 0, count:uint = 0, total:uint = 0, guilds:Vector.<GuildFactSheetInformations> = null) : GuildSummaryMessage
      {
         super.initPaginationAnswerAbstractMessage(offset,count,total);
         this.guilds = guilds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guilds = new Vector.<GuildFactSheetInformations>();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildSummaryMessage(output);
      }
      
      public function serializeAs_GuildSummaryMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaginationAnswerAbstractMessage(output);
         output.writeShort(this.guilds.length);
         for(var _i1:uint = 0; _i1 < this.guilds.length; _i1++)
         {
            (this.guilds[_i1] as GuildFactSheetInformations).serializeAs_GuildFactSheetInformations(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildSummaryMessage(input);
      }
      
      public function deserializeAs_GuildSummaryMessage(input:ICustomDataInput) : void
      {
         var _item1:GuildFactSheetInformations = null;
         super.deserialize(input);
         var _guildsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _guildsLen; _i1++)
         {
            _item1 = new GuildFactSheetInformations();
            _item1.deserialize(input);
            this.guilds.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildSummaryMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildSummaryMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildstree = tree.addChild(this._guildstreeFunc);
      }
      
      private function _guildstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._guildstree.addChild(this._guildsFunc);
         }
      }
      
      private function _guildsFunc(input:ICustomDataInput) : void
      {
         var _item:GuildFactSheetInformations = new GuildFactSheetInformations();
         _item.deserialize(input);
         this.guilds.push(_item);
      }
   }
}
