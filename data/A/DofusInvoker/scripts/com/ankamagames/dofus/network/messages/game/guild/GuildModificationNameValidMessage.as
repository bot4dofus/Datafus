package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildModificationNameValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2309;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildName:String = "";
      
      public function GuildModificationNameValidMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2309;
      }
      
      public function initGuildModificationNameValidMessage(guildName:String = "") : GuildModificationNameValidMessage
      {
         this.guildName = guildName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildName = "";
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
         this.serializeAs_GuildModificationNameValidMessage(output);
      }
      
      public function serializeAs_GuildModificationNameValidMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.guildName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildModificationNameValidMessage(input);
      }
      
      public function deserializeAs_GuildModificationNameValidMessage(input:ICustomDataInput) : void
      {
         this._guildNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildModificationNameValidMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildModificationNameValidMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guildNameFunc);
      }
      
      private function _guildNameFunc(input:ICustomDataInput) : void
      {
         this.guildName = input.readUTF();
      }
   }
}
