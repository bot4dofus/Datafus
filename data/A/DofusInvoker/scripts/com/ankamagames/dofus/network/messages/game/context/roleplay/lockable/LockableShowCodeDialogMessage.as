package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LockableShowCodeDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9268;
       
      
      private var _isInitialized:Boolean = false;
      
      public var changeOrUse:Boolean = false;
      
      public var codeSize:uint = 0;
      
      public function LockableShowCodeDialogMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9268;
      }
      
      public function initLockableShowCodeDialogMessage(changeOrUse:Boolean = false, codeSize:uint = 0) : LockableShowCodeDialogMessage
      {
         this.changeOrUse = changeOrUse;
         this.codeSize = codeSize;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.changeOrUse = false;
         this.codeSize = 0;
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
         this.serializeAs_LockableShowCodeDialogMessage(output);
      }
      
      public function serializeAs_LockableShowCodeDialogMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.changeOrUse);
         if(this.codeSize < 0)
         {
            throw new Error("Forbidden value (" + this.codeSize + ") on element codeSize.");
         }
         output.writeByte(this.codeSize);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LockableShowCodeDialogMessage(input);
      }
      
      public function deserializeAs_LockableShowCodeDialogMessage(input:ICustomDataInput) : void
      {
         this._changeOrUseFunc(input);
         this._codeSizeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LockableShowCodeDialogMessage(tree);
      }
      
      public function deserializeAsyncAs_LockableShowCodeDialogMessage(tree:FuncTree) : void
      {
         tree.addChild(this._changeOrUseFunc);
         tree.addChild(this._codeSizeFunc);
      }
      
      private function _changeOrUseFunc(input:ICustomDataInput) : void
      {
         this.changeOrUse = input.readBoolean();
      }
      
      private function _codeSizeFunc(input:ICustomDataInput) : void
      {
         this.codeSize = input.readByte();
         if(this.codeSize < 0)
         {
            throw new Error("Forbidden value (" + this.codeSize + ") on element of LockableShowCodeDialogMessage.codeSize.");
         }
      }
   }
}
