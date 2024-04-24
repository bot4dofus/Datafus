package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountSetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 792;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountData:MountClientData;
      
      private var _mountDatatree:FuncTree;
      
      public function MountSetMessage()
      {
         this.mountData = new MountClientData();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 792;
      }
      
      public function initMountSetMessage(mountData:MountClientData = null) : MountSetMessage
      {
         this.mountData = mountData;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountData = new MountClientData();
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
         this.serializeAs_MountSetMessage(output);
      }
      
      public function serializeAs_MountSetMessage(output:ICustomDataOutput) : void
      {
         this.mountData.serializeAs_MountClientData(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountSetMessage(input);
      }
      
      public function deserializeAs_MountSetMessage(input:ICustomDataInput) : void
      {
         this.mountData = new MountClientData();
         this.mountData.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountSetMessage(tree);
      }
      
      public function deserializeAsyncAs_MountSetMessage(tree:FuncTree) : void
      {
         this._mountDatatree = tree.addChild(this._mountDatatreeFunc);
      }
      
      private function _mountDatatreeFunc(input:ICustomDataInput) : void
      {
         this.mountData = new MountClientData();
         this.mountData.deserializeAsync(this._mountDatatree);
      }
   }
}
