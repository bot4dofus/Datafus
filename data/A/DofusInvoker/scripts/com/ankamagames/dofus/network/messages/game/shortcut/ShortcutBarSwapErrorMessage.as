package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShortcutBarSwapErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6501;
       
      
      private var _isInitialized:Boolean = false;
      
      public var error:uint = 0;
      
      public function ShortcutBarSwapErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6501;
      }
      
      public function initShortcutBarSwapErrorMessage(error:uint = 0) : ShortcutBarSwapErrorMessage
      {
         this.error = error;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.error = 0;
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
         this.serializeAs_ShortcutBarSwapErrorMessage(output);
      }
      
      public function serializeAs_ShortcutBarSwapErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.error);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarSwapErrorMessage(input);
      }
      
      public function deserializeAs_ShortcutBarSwapErrorMessage(input:ICustomDataInput) : void
      {
         this._errorFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutBarSwapErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_ShortcutBarSwapErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._errorFunc);
      }
      
      private function _errorFunc(input:ICustomDataInput) : void
      {
         this.error = input.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of ShortcutBarSwapErrorMessage.error.");
         }
      }
   }
}
