package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildApplicationDeletedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8782;
       
      
      private var _isInitialized:Boolean = false;
      
      public var deleted:Boolean = false;
      
      public function GuildApplicationDeletedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8782;
      }
      
      public function initGuildApplicationDeletedMessage(deleted:Boolean = false) : GuildApplicationDeletedMessage
      {
         this.deleted = deleted;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.deleted = false;
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
         this.serializeAs_GuildApplicationDeletedMessage(output);
      }
      
      public function serializeAs_GuildApplicationDeletedMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.deleted);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildApplicationDeletedMessage(input);
      }
      
      public function deserializeAs_GuildApplicationDeletedMessage(input:ICustomDataInput) : void
      {
         this._deletedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildApplicationDeletedMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildApplicationDeletedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._deletedFunc);
      }
      
      private function _deletedFunc(input:ICustomDataInput) : void
      {
         this.deleted = input.readBoolean();
      }
   }
}
