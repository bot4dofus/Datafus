package com.ankamagames.dofus.network.messages.game.guild.chest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RemoveListenerOnSynchronizedStorageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 91;
       
      
      private var _isInitialized:Boolean = false;
      
      public var player:String = "";
      
      public function RemoveListenerOnSynchronizedStorageMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 91;
      }
      
      public function initRemoveListenerOnSynchronizedStorageMessage(player:String = "") : RemoveListenerOnSynchronizedStorageMessage
      {
         this.player = player;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.player = "";
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
         this.serializeAs_RemoveListenerOnSynchronizedStorageMessage(output);
      }
      
      public function serializeAs_RemoveListenerOnSynchronizedStorageMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.player);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RemoveListenerOnSynchronizedStorageMessage(input);
      }
      
      public function deserializeAs_RemoveListenerOnSynchronizedStorageMessage(input:ICustomDataInput) : void
      {
         this._playerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RemoveListenerOnSynchronizedStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_RemoveListenerOnSynchronizedStorageMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerFunc);
      }
      
      private function _playerFunc(input:ICustomDataInput) : void
      {
         this.player = input.readUTF();
      }
   }
}
