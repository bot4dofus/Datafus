package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShortcutBarAddErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1627;
       
      
      private var _isInitialized:Boolean = false;
      
      public var error:uint = 0;
      
      public function ShortcutBarAddErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1627;
      }
      
      public function initShortcutBarAddErrorMessage(error:uint = 0) : ShortcutBarAddErrorMessage
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
         this.serializeAs_ShortcutBarAddErrorMessage(output);
      }
      
      public function serializeAs_ShortcutBarAddErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.error);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarAddErrorMessage(input);
      }
      
      public function deserializeAs_ShortcutBarAddErrorMessage(input:ICustomDataInput) : void
      {
         this._errorFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutBarAddErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_ShortcutBarAddErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._errorFunc);
      }
      
      private function _errorFunc(input:ICustomDataInput) : void
      {
         this.error = input.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of ShortcutBarAddErrorMessage.error.");
         }
      }
   }
}
