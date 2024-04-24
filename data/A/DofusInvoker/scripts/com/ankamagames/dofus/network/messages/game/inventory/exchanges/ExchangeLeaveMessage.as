package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeLeaveMessage extends LeaveDialogMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8715;
       
      
      private var _isInitialized:Boolean = false;
      
      public var success:Boolean = false;
      
      public function ExchangeLeaveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8715;
      }
      
      public function initExchangeLeaveMessage(dialogType:uint = 0, success:Boolean = false) : ExchangeLeaveMessage
      {
         super.initLeaveDialogMessage(dialogType);
         this.success = success;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.success = false;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeLeaveMessage(output);
      }
      
      public function serializeAs_ExchangeLeaveMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_LeaveDialogMessage(output);
         output.writeBoolean(this.success);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeLeaveMessage(input);
      }
      
      public function deserializeAs_ExchangeLeaveMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._successFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeLeaveMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeLeaveMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._successFunc);
      }
      
      private function _successFunc(input:ICustomDataInput) : void
      {
         this.success = input.readBoolean();
      }
   }
}
