package com.ankamagames.dofus.network.messages.game.context.notification
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NotificationListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1568;
       
      
      private var _isInitialized:Boolean = false;
      
      public var flags:Vector.<int>;
      
      private var _flagstree:FuncTree;
      
      public function NotificationListMessage()
      {
         this.flags = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1568;
      }
      
      public function initNotificationListMessage(flags:Vector.<int> = null) : NotificationListMessage
      {
         this.flags = flags;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.flags = new Vector.<int>();
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
         this.serializeAs_NotificationListMessage(output);
      }
      
      public function serializeAs_NotificationListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.flags.length);
         for(var _i1:uint = 0; _i1 < this.flags.length; _i1++)
         {
            output.writeVarInt(this.flags[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NotificationListMessage(input);
      }
      
      public function deserializeAs_NotificationListMessage(input:ICustomDataInput) : void
      {
         var _val1:int = 0;
         var _flagsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _flagsLen; _i1++)
         {
            _val1 = input.readVarInt();
            this.flags.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NotificationListMessage(tree);
      }
      
      public function deserializeAsyncAs_NotificationListMessage(tree:FuncTree) : void
      {
         this._flagstree = tree.addChild(this._flagstreeFunc);
      }
      
      private function _flagstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._flagstree.addChild(this._flagsFunc);
         }
      }
      
      private function _flagsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readVarInt();
         this.flags.push(_val);
      }
   }
}
