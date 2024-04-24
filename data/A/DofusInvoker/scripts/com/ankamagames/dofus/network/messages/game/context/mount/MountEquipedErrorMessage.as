package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountEquipedErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2813;
       
      
      private var _isInitialized:Boolean = false;
      
      public var errorType:uint = 0;
      
      public function MountEquipedErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2813;
      }
      
      public function initMountEquipedErrorMessage(errorType:uint = 0) : MountEquipedErrorMessage
      {
         this.errorType = errorType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.errorType = 0;
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
         this.serializeAs_MountEquipedErrorMessage(output);
      }
      
      public function serializeAs_MountEquipedErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.errorType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountEquipedErrorMessage(input);
      }
      
      public function deserializeAs_MountEquipedErrorMessage(input:ICustomDataInput) : void
      {
         this._errorTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountEquipedErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_MountEquipedErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._errorTypeFunc);
      }
      
      private function _errorTypeFunc(input:ICustomDataInput) : void
      {
         this.errorType = input.readByte();
         if(this.errorType < 0)
         {
            throw new Error("Forbidden value (" + this.errorType + ") on element of MountEquipedErrorMessage.errorType.");
         }
      }
   }
}
