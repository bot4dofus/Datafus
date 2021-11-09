package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInvitedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7407;
       
      
      private var _isInitialized:Boolean = false;
      
      public var recruterId:Number = 0;
      
      public var recruterName:String = "";
      
      public var guildInfo:BasicGuildInformations;
      
      private var _guildInfotree:FuncTree;
      
      public function GuildInvitedMessage()
      {
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7407;
      }
      
      public function initGuildInvitedMessage(recruterId:Number = 0, recruterName:String = "", guildInfo:BasicGuildInformations = null) : GuildInvitedMessage
      {
         this.recruterId = recruterId;
         this.recruterName = recruterName;
         this.guildInfo = guildInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recruterId = 0;
         this.recruterName = "";
         this.guildInfo = new BasicGuildInformations();
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
         if(this.recruterId < 0 || this.recruterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element recruterId.");
         }
         output.writeVarLong(this.recruterId);
         output.writeUTF(this.recruterName);
         this.guildInfo.serializeAs_BasicGuildInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInvitedMessage(input);
      }
      
      public function deserializeAs_GuildInvitedMessage(input:ICustomDataInput) : void
      {
         this._recruterIdFunc(input);
         this._recruterNameFunc(input);
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInvitedMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInvitedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._recruterIdFunc);
         tree.addChild(this._recruterNameFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
      }
      
      private function _recruterIdFunc(input:ICustomDataInput) : void
      {
         this.recruterId = input.readVarUhLong();
         if(this.recruterId < 0 || this.recruterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element of GuildInvitedMessage.recruterId.");
         }
      }
      
      private function _recruterNameFunc(input:ICustomDataInput) : void
      {
         this.recruterName = input.readUTF();
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
   }
}
