package com.ankamagames.dofus.network.messages.game.shortcut
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShortcutBarReplacedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 125;
       
      
      private var _isInitialized:Boolean = false;
      
      public var barType:uint = 0;
      
      public var shortcut:Shortcut;
      
      private var _shortcuttree:FuncTree;
      
      public function ShortcutBarReplacedMessage()
      {
         this.shortcut = new Shortcut();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 125;
      }
      
      public function initShortcutBarReplacedMessage(barType:uint = 0, shortcut:Shortcut = null) : ShortcutBarReplacedMessage
      {
         this.barType = barType;
         this.shortcut = shortcut;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.barType = 0;
         this.shortcut = new Shortcut();
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
         this.serializeAs_ShortcutBarReplacedMessage(output);
      }
      
      public function serializeAs_ShortcutBarReplacedMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.barType);
         output.writeShort(this.shortcut.getTypeId());
         this.shortcut.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarReplacedMessage(input);
      }
      
      public function deserializeAs_ShortcutBarReplacedMessage(input:ICustomDataInput) : void
      {
         this._barTypeFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.shortcut = ProtocolTypeManager.getInstance(Shortcut,_id2);
         this.shortcut.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutBarReplacedMessage(tree);
      }
      
      public function deserializeAsyncAs_ShortcutBarReplacedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._barTypeFunc);
         this._shortcuttree = tree.addChild(this._shortcuttreeFunc);
      }
      
      private function _barTypeFunc(input:ICustomDataInput) : void
      {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarReplacedMessage.barType.");
         }
      }
      
      private function _shortcuttreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.shortcut = ProtocolTypeManager.getInstance(Shortcut,_id);
         this.shortcut.deserializeAsync(this._shortcuttree);
      }
   }
}
