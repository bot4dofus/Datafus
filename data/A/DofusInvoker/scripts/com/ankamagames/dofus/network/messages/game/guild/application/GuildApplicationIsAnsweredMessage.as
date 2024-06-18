package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildApplicationIsAnsweredMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3637;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accepted:Boolean = false;
      
      public var guildInformation:GuildInformations;
      
      private var _guildInformationtree:FuncTree;
      
      public function GuildApplicationIsAnsweredMessage()
      {
         this.guildInformation = new GuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3637;
      }
      
      public function initGuildApplicationIsAnsweredMessage(accepted:Boolean = false, guildInformation:GuildInformations = null) : GuildApplicationIsAnsweredMessage
      {
         this.accepted = accepted;
         this.guildInformation = guildInformation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accepted = false;
         this.guildInformation = new GuildInformations();
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
         this.serializeAs_GuildApplicationIsAnsweredMessage(output);
      }
      
      public function serializeAs_GuildApplicationIsAnsweredMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accepted);
         this.guildInformation.serializeAs_GuildInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildApplicationIsAnsweredMessage(input);
      }
      
      public function deserializeAs_GuildApplicationIsAnsweredMessage(input:ICustomDataInput) : void
      {
         this._acceptedFunc(input);
         this.guildInformation = new GuildInformations();
         this.guildInformation.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildApplicationIsAnsweredMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildApplicationIsAnsweredMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptedFunc);
         this._guildInformationtree = tree.addChild(this._guildInformationtreeFunc);
      }
      
      private function _acceptedFunc(input:ICustomDataInput) : void
      {
         this.accepted = input.readBoolean();
      }
      
      private function _guildInformationtreeFunc(input:ICustomDataInput) : void
      {
         this.guildInformation = new GuildInformations();
         this.guildInformation.deserializeAsync(this._guildInformationtree);
      }
   }
}
