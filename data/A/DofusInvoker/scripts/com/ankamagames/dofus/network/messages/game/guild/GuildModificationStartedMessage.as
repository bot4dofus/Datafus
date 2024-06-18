package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildModificationStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 515;
       
      
      private var _isInitialized:Boolean = false;
      
      public var canChangeName:Boolean = false;
      
      public var canChangeEmblem:Boolean = false;
      
      public function GuildModificationStartedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 515;
      }
      
      public function initGuildModificationStartedMessage(canChangeName:Boolean = false, canChangeEmblem:Boolean = false) : GuildModificationStartedMessage
      {
         this.canChangeName = canChangeName;
         this.canChangeEmblem = canChangeEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.canChangeName = false;
         this.canChangeEmblem = false;
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
         this.serializeAs_GuildModificationStartedMessage(output);
      }
      
      public function serializeAs_GuildModificationStartedMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.canChangeName);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.canChangeEmblem);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildModificationStartedMessage(input);
      }
      
      public function deserializeAs_GuildModificationStartedMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildModificationStartedMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildModificationStartedMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.canChangeName = BooleanByteWrapper.getFlag(_box0,0);
         this.canChangeEmblem = BooleanByteWrapper.getFlag(_box0,1);
      }
   }
}
