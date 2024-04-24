package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
   import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HavenBagRoomUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5144;
       
      
      private var _isInitialized:Boolean = false;
      
      public var action:uint = 0;
      
      public var roomsPreview:Vector.<HavenBagRoomPreviewInformation>;
      
      private var _roomsPreviewtree:FuncTree;
      
      public function HavenBagRoomUpdateMessage()
      {
         this.roomsPreview = new Vector.<HavenBagRoomPreviewInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5144;
      }
      
      public function initHavenBagRoomUpdateMessage(action:uint = 0, roomsPreview:Vector.<HavenBagRoomPreviewInformation> = null) : HavenBagRoomUpdateMessage
      {
         this.action = action;
         this.roomsPreview = roomsPreview;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.action = 0;
         this.roomsPreview = new Vector.<HavenBagRoomPreviewInformation>();
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
         this.serializeAs_HavenBagRoomUpdateMessage(output);
      }
      
      public function serializeAs_HavenBagRoomUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.action);
         output.writeShort(this.roomsPreview.length);
         for(var _i2:uint = 0; _i2 < this.roomsPreview.length; _i2++)
         {
            (this.roomsPreview[_i2] as HavenBagRoomPreviewInformation).serializeAs_HavenBagRoomPreviewInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HavenBagRoomUpdateMessage(input);
      }
      
      public function deserializeAs_HavenBagRoomUpdateMessage(input:ICustomDataInput) : void
      {
         var _item2:HavenBagRoomPreviewInformation = null;
         this._actionFunc(input);
         var _roomsPreviewLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _roomsPreviewLen; _i2++)
         {
            _item2 = new HavenBagRoomPreviewInformation();
            _item2.deserialize(input);
            this.roomsPreview.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HavenBagRoomUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_HavenBagRoomUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actionFunc);
         this._roomsPreviewtree = tree.addChild(this._roomsPreviewtreeFunc);
      }
      
      private function _actionFunc(input:ICustomDataInput) : void
      {
         this.action = input.readByte();
         if(this.action < 0)
         {
            throw new Error("Forbidden value (" + this.action + ") on element of HavenBagRoomUpdateMessage.action.");
         }
      }
      
      private function _roomsPreviewtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._roomsPreviewtree.addChild(this._roomsPreviewFunc);
         }
      }
      
      private function _roomsPreviewFunc(input:ICustomDataInput) : void
      {
         var _item:HavenBagRoomPreviewInformation = new HavenBagRoomPreviewInformation();
         _item.deserialize(input);
         this.roomsPreview.push(_item);
      }
   }
}
