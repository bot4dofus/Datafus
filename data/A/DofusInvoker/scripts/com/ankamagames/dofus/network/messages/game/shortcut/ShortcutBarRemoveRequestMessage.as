package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShortcutBarRemoveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4369;
       
      
      private var _isInitialized:Boolean = false;
      
      public var barType:uint = 0;
      
      public var slot:uint = 0;
      
      public function ShortcutBarRemoveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4369;
      }
      
      public function initShortcutBarRemoveRequestMessage(barType:uint = 0, slot:uint = 0) : ShortcutBarRemoveRequestMessage
      {
         this.barType = barType;
         this.slot = slot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.barType = 0;
         this.slot = 0;
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
         this.serializeAs_ShortcutBarRemoveRequestMessage(output);
      }
      
      public function serializeAs_ShortcutBarRemoveRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.barType);
         if(this.slot < 0 || this.slot > 99)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element slot.");
         }
         output.writeByte(this.slot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarRemoveRequestMessage(input);
      }
      
      public function deserializeAs_ShortcutBarRemoveRequestMessage(input:ICustomDataInput) : void
      {
         this._barTypeFunc(input);
         this._slotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutBarRemoveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ShortcutBarRemoveRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._barTypeFunc);
         tree.addChild(this._slotFunc);
      }
      
      private function _barTypeFunc(input:ICustomDataInput) : void
      {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarRemoveRequestMessage.barType.");
         }
      }
      
      private function _slotFunc(input:ICustomDataInput) : void
      {
         this.slot = input.readByte();
         if(this.slot < 0 || this.slot > 99)
         {
            throw new Error("Forbidden value (" + this.slot + ") on element of ShortcutBarRemoveRequestMessage.slot.");
         }
      }
   }
}
