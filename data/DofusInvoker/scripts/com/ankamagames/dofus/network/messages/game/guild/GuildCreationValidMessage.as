package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildCreationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7774;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildName:String = "";
      
      public var guildEmblem:GuildEmblem;
      
      private var _guildEmblemtree:FuncTree;
      
      public function GuildCreationValidMessage()
      {
         this.guildEmblem = new GuildEmblem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7774;
      }
      
      public function initGuildCreationValidMessage(guildName:String = "", guildEmblem:GuildEmblem = null) : GuildCreationValidMessage
      {
         this.guildName = guildName;
         this.guildEmblem = guildEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildName = "";
         this.guildEmblem = new GuildEmblem();
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
         this.serializeAs_GuildCreationValidMessage(output);
      }
      
      public function serializeAs_GuildCreationValidMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.guildName);
         this.guildEmblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildCreationValidMessage(input);
      }
      
      public function deserializeAs_GuildCreationValidMessage(input:ICustomDataInput) : void
      {
         this._guildNameFunc(input);
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildCreationValidMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildCreationValidMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guildNameFunc);
         this._guildEmblemtree = tree.addChild(this._guildEmblemtreeFunc);
      }
      
      private function _guildNameFunc(input:ICustomDataInput) : void
      {
         this.guildName = input.readUTF();
      }
      
      private function _guildEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.guildEmblem = new GuildEmblem();
         this.guildEmblem.deserializeAsync(this._guildEmblemtree);
      }
   }
}
