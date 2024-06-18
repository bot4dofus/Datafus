package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountRenamedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2688;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountId:int = 0;
      
      public var name:String = "";
      
      public function MountRenamedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2688;
      }
      
      public function initMountRenamedMessage(mountId:int = 0, name:String = "") : MountRenamedMessage
      {
         this.mountId = mountId;
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountId = 0;
         this.name = "";
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
         this.serializeAs_MountRenamedMessage(output);
      }
      
      public function serializeAs_MountRenamedMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.mountId);
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountRenamedMessage(input);
      }
      
      public function deserializeAs_MountRenamedMessage(input:ICustomDataInput) : void
      {
         this._mountIdFunc(input);
         this._nameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountRenamedMessage(tree);
      }
      
      public function deserializeAsyncAs_MountRenamedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mountIdFunc);
         tree.addChild(this._nameFunc);
      }
      
      private function _mountIdFunc(input:ICustomDataInput) : void
      {
         this.mountId = input.readVarInt();
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
