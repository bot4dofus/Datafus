package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShortcutBarSwapRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9161;
       
      
      private var _isInitialized:Boolean = false;
      
      public var barType:uint = 0;
      
      public var firstSlot:uint = 0;
      
      public var secondSlot:uint = 0;
      
      public function ShortcutBarSwapRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9161;
      }
      
      public function initShortcutBarSwapRequestMessage(barType:uint = 0, firstSlot:uint = 0, secondSlot:uint = 0) : ShortcutBarSwapRequestMessage
      {
         this.barType = barType;
         this.firstSlot = firstSlot;
         this.secondSlot = secondSlot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.barType = 0;
         this.firstSlot = 0;
         this.secondSlot = 0;
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
         this.serializeAs_ShortcutBarSwapRequestMessage(output);
      }
      
      public function serializeAs_ShortcutBarSwapRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.barType);
         if(this.firstSlot < 0 || this.firstSlot > 99)
         {
            throw new Error("Forbidden value (" + this.firstSlot + ") on element firstSlot.");
         }
         output.writeByte(this.firstSlot);
         if(this.secondSlot < 0 || this.secondSlot > 99)
         {
            throw new Error("Forbidden value (" + this.secondSlot + ") on element secondSlot.");
         }
         output.writeByte(this.secondSlot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarSwapRequestMessage(input);
      }
      
      public function deserializeAs_ShortcutBarSwapRequestMessage(input:ICustomDataInput) : void
      {
         this._barTypeFunc(input);
         this._firstSlotFunc(input);
         this._secondSlotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutBarSwapRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ShortcutBarSwapRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._barTypeFunc);
         tree.addChild(this._firstSlotFunc);
         tree.addChild(this._secondSlotFunc);
      }
      
      private function _barTypeFunc(input:ICustomDataInput) : void
      {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarSwapRequestMessage.barType.");
         }
      }
      
      private function _firstSlotFunc(input:ICustomDataInput) : void
      {
         this.firstSlot = input.readByte();
         if(this.firstSlot < 0 || this.firstSlot > 99)
         {
            throw new Error("Forbidden value (" + this.firstSlot + ") on element of ShortcutBarSwapRequestMessage.firstSlot.");
         }
      }
      
      private function _secondSlotFunc(input:ICustomDataInput) : void
      {
         this.secondSlot = input.readByte();
         if(this.secondSlot < 0 || this.secondSlot > 99)
         {
            throw new Error("Forbidden value (" + this.secondSlot + ") on element of ShortcutBarSwapRequestMessage.secondSlot.");
         }
      }
   }
}
