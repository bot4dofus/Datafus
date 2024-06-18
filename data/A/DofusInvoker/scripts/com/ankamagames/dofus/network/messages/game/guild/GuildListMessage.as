package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 669;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guilds:Vector.<GuildInformations>;
      
      private var _guildstree:FuncTree;
      
      public function GuildListMessage()
      {
         this.guilds = new Vector.<GuildInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 669;
      }
      
      public function initGuildListMessage(guilds:Vector.<GuildInformations> = null) : GuildListMessage
      {
         this.guilds = guilds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guilds = new Vector.<GuildInformations>();
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
         this.serializeAs_GuildListMessage(output);
      }
      
      public function serializeAs_GuildListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.guilds.length);
         for(var _i1:uint = 0; _i1 < this.guilds.length; _i1++)
         {
            (this.guilds[_i1] as GuildInformations).serializeAs_GuildInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildListMessage(input);
      }
      
      public function deserializeAs_GuildListMessage(input:ICustomDataInput) : void
      {
         var _item1:GuildInformations = null;
         var _guildsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _guildsLen; _i1++)
         {
            _item1 = new GuildInformations();
            _item1.deserialize(input);
            this.guilds.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildListMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildListMessage(tree:FuncTree) : void
      {
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
         var _item:GuildInformations = new GuildInformations();
         _item.deserialize(input);
         this.guilds.push(_item);
      }
   }
}
