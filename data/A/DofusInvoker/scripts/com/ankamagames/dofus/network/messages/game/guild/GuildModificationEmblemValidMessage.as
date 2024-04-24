package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1754;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildEmblem:SocialEmblem;
      
      private var _guildEmblemtree:FuncTree;
      
      public function GuildModificationEmblemValidMessage()
      {
         this.guildEmblem = new SocialEmblem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1754;
      }
      
      public function initGuildModificationEmblemValidMessage(guildEmblem:SocialEmblem = null) : GuildModificationEmblemValidMessage
      {
         this.guildEmblem = guildEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildEmblem = new SocialEmblem();
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
         this.serializeAs_GuildModificationEmblemValidMessage(output);
      }
      
      public function serializeAs_GuildModificationEmblemValidMessage(output:ICustomDataOutput) : void
      {
         this.guildEmblem.serializeAs_SocialEmblem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildModificationEmblemValidMessage(input);
      }
      
      public function deserializeAs_GuildModificationEmblemValidMessage(input:ICustomDataInput) : void
      {
         this.guildEmblem = new SocialEmblem();
         this.guildEmblem.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildModificationEmblemValidMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildModificationEmblemValidMessage(tree:FuncTree) : void
      {
         this._guildEmblemtree = tree.addChild(this._guildEmblemtreeFunc);
      }
      
      private function _guildEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.guildEmblem = new SocialEmblem();
         this.guildEmblem.deserializeAsync(this._guildEmblemtree);
      }
   }
}
