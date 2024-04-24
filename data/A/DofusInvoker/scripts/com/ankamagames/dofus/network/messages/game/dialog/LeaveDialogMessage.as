package com.ankamagames.dofus.network.messages.game.dialog
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LeaveDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8958;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dialogType:uint = 0;
      
      public function LeaveDialogMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8958;
      }
      
      public function initLeaveDialogMessage(dialogType:uint = 0) : LeaveDialogMessage
      {
         this.dialogType = dialogType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dialogType = 0;
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
         this.serializeAs_LeaveDialogMessage(output);
      }
      
      public function serializeAs_LeaveDialogMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.dialogType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LeaveDialogMessage(input);
      }
      
      public function deserializeAs_LeaveDialogMessage(input:ICustomDataInput) : void
      {
         this._dialogTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LeaveDialogMessage(tree);
      }
      
      public function deserializeAsyncAs_LeaveDialogMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dialogTypeFunc);
      }
      
      private function _dialogTypeFunc(input:ICustomDataInput) : void
      {
         this.dialogType = input.readByte();
         if(this.dialogType < 0)
         {
            throw new Error("Forbidden value (" + this.dialogType + ") on element of LeaveDialogMessage.dialogType.");
         }
      }
   }
}
