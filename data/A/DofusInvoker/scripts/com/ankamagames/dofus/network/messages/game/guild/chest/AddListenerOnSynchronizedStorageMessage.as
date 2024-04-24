package com.ankamagames.dofus.network.messages.game.guild.chest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AddListenerOnSynchronizedStorageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9782;
       
      
      private var _isInitialized:Boolean = false;
      
      public var player:String = "";
      
      public function AddListenerOnSynchronizedStorageMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9782;
      }
      
      public function initAddListenerOnSynchronizedStorageMessage(player:String = "") : AddListenerOnSynchronizedStorageMessage
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
         this.serializeAs_AddListenerOnSynchronizedStorageMessage(output);
      }
      
      public function serializeAs_AddListenerOnSynchronizedStorageMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.player);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AddListenerOnSynchronizedStorageMessage(input);
      }
      
      public function deserializeAs_AddListenerOnSynchronizedStorageMessage(input:ICustomDataInput) : void
      {
         this._playerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AddListenerOnSynchronizedStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_AddListenerOnSynchronizedStorageMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerFunc);
      }
      
      private function _playerFunc(input:ICustomDataInput) : void
      {
         this.player = input.readUTF();
      }
   }
}
