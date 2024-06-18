package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountSterilizedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9430;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountId:int = 0;
      
      public function MountSterilizedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9430;
      }
      
      public function initMountSterilizedMessage(mountId:int = 0) : MountSterilizedMessage
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
         this.serializeAs_MountSterilizedMessage(output);
      }
      
      public function serializeAs_MountSterilizedMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.mountId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountSterilizedMessage(input);
      }
      
      public function deserializeAs_MountSterilizedMessage(input:ICustomDataInput) : void
      {
         this._mountIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountSterilizedMessage(tree);
      }
      
      public function deserializeAsyncAs_MountSterilizedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mountIdFunc);
      }
      
      private function _mountIdFunc(input:ICustomDataInput) : void
      {
         this.mountId = input.readVarInt();
      }
   }
}
