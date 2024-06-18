package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildUpdateApplicationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7570;
       
      
      private var _isInitialized:Boolean = false;
      
      public var applyText:String = "";
      
      public var guildId:uint = 0;
      
      public function GuildUpdateApplicationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7570;
      }
      
      public function initGuildUpdateApplicationMessage(applyText:String = "", guildId:uint = 0) : GuildUpdateApplicationMessage
      {
         this.applyText = applyText;
         this.guildId = guildId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.applyText = "";
         this.guildId = 0;
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
         this.serializeAs_GuildUpdateApplicationMessage(output);
      }
      
      public function serializeAs_GuildUpdateApplicationMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.applyText);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildUpdateApplicationMessage(input);
      }
      
      public function deserializeAs_GuildUpdateApplicationMessage(input:ICustomDataInput) : void
      {
         this._applyTextFunc(input);
         this._guildIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildUpdateApplicationMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildUpdateApplicationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._applyTextFunc);
         tree.addChild(this._guildIdFunc);
      }
      
      private function _applyTextFunc(input:ICustomDataInput) : void
      {
         this.applyText = input.readUTF();
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of GuildUpdateApplicationMessage.guildId.");
         }
      }
   }
}
