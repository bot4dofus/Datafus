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
   
   public class ShortcutBarContentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8634;
       
      
      private var _isInitialized:Boolean = false;
      
      public var barType:uint = 0;
      
      public var shortcuts:Vector.<Shortcut>;
      
      private var _shortcutstree:FuncTree;
      
      public function ShortcutBarContentMessage()
      {
         this.shortcuts = new Vector.<Shortcut>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8634;
      }
      
      public function initShortcutBarContentMessage(barType:uint = 0, shortcuts:Vector.<Shortcut> = null) : ShortcutBarContentMessage
      {
         this.barType = barType;
         this.shortcuts = shortcuts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.barType = 0;
         this.shortcuts = new Vector.<Shortcut>();
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
         this.serializeAs_ShortcutBarContentMessage(output);
      }
      
      public function serializeAs_ShortcutBarContentMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.barType);
         output.writeShort(this.shortcuts.length);
         for(var _i2:uint = 0; _i2 < this.shortcuts.length; _i2++)
         {
            output.writeShort((this.shortcuts[_i2] as Shortcut).getTypeId());
            (this.shortcuts[_i2] as Shortcut).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutBarContentMessage(input);
      }
      
      public function deserializeAs_ShortcutBarContentMessage(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:Shortcut = null;
         this._barTypeFunc(input);
         var _shortcutsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _shortcutsLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(Shortcut,_id2);
            _item2.deserialize(input);
            this.shortcuts.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutBarContentMessage(tree);
      }
      
      public function deserializeAsyncAs_ShortcutBarContentMessage(tree:FuncTree) : void
      {
         tree.addChild(this._barTypeFunc);
         this._shortcutstree = tree.addChild(this._shortcutstreeFunc);
      }
      
      private function _barTypeFunc(input:ICustomDataInput) : void
      {
         this.barType = input.readByte();
         if(this.barType < 0)
         {
            throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarContentMessage.barType.");
         }
      }
      
      private function _shortcutstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._shortcutstree.addChild(this._shortcutsFunc);
         }
      }
      
      private function _shortcutsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:Shortcut = ProtocolTypeManager.getInstance(Shortcut,_id);
         _item.deserialize(input);
         this.shortcuts.push(_item);
      }
   }
}
