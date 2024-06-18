package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatServerCopyWithObjectMessage extends ChatServerCopyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8059;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objects:Vector.<ObjectItem>;
      
      private var _objectstree:FuncTree;
      
      public function ChatServerCopyWithObjectMessage()
      {
         this.objects = new Vector.<ObjectItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8059;
      }
      
      public function initChatServerCopyWithObjectMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "", receiverId:Number = 0, receiverName:String = "", objects:Vector.<ObjectItem> = null) : ChatServerCopyWithObjectMessage
      {
         super.initChatServerCopyMessage(channel,content,timestamp,fingerprint,receiverId,receiverName);
         this.objects = objects;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.objects = new Vector.<ObjectItem>();
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
         this.serializeAs_ChatServerCopyWithObjectMessage(output);
      }
      
      public function serializeAs_ChatServerCopyWithObjectMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatServerCopyMessage(output);
         output.writeShort(this.objects.length);
         for(var _i1:uint = 0; _i1 < this.objects.length; _i1++)
         {
            (this.objects[_i1] as ObjectItem).serializeAs_ObjectItem(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatServerCopyWithObjectMessage(input);
      }
      
      public function deserializeAs_ChatServerCopyWithObjectMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItem = null;
         super.deserialize(input);
         var _objectsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectsLen; _i1++)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.objects.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatServerCopyWithObjectMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatServerCopyWithObjectMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._objectstree = tree.addChild(this._objectstreeFunc);
      }
      
      private function _objectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectstree.addChild(this._objectsFunc);
         }
      }
      
      private function _objectsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItem = new ObjectItem();
         _item.deserialize(input);
         this.objects.push(_item);
      }
   }
}
