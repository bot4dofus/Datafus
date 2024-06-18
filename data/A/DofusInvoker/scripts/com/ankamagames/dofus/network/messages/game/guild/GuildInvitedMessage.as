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
   
   public class GuildInvitedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4003;
       
      
      private var _isInitialized:Boolean = false;
      
      public var recruterName:String = "";
      
      public var guildInfo:GuildInformations;
      
      private var _guildInfotree:FuncTree;
      
      public function GuildInvitedMessage()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4003;
      }
      
      public function initGuildInvitedMessage(recruterName:String = "", guildInfo:GuildInformations = null) : GuildInvitedMessage
      {
         this.recruterName = recruterName;
         this.guildInfo = guildInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recruterName = "";
         this.guildInfo = new GuildInformations();
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
         this.serializeAs_GuildInvitedMessage(output);
      }
      
      public function serializeAs_GuildInvitedMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.recruterName);
         this.guildInfo.serializeAs_GuildInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInvitedMessage(input);
      }
      
      public function deserializeAs_GuildInvitedMessage(input:ICustomDataInput) : void
      {
         this._recruterNameFunc(input);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInvitedMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInvitedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._recruterNameFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
      }
      
      private function _recruterNameFunc(input:ICustomDataInput) : void
      {
         this.recruterName = input.readUTF();
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
   }
}
