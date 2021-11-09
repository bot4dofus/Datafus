package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountReleasedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7683;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountId:int = 0;
      
      public function MountReleasedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7683;
      }
      
      public function initMountReleasedMessage(mountId:int = 0) : MountReleasedMessage
      {
         this.mountId = mountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountId = 0;
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
         this.serializeAs_MountReleasedMessage(output);
      }
      
      public function serializeAs_MountReleasedMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.mountId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountReleasedMessage(input);
      }
      
      public function deserializeAs_MountReleasedMessage(input:ICustomDataInput) : void
      {
         this._mountIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountReleasedMessage(tree);
      }
      
      public function deserializeAsyncAs_MountReleasedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mountIdFunc);
      }
      
      private function _mountIdFunc(input:ICustomDataInput) : void
      {
         this.mountId = input.readVarInt();
      }
   }
}
