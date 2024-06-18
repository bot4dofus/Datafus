package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.dofus.network.types.game.interactive.zaap.TeleportDestination;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportDestinationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7615;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public var destinations:Vector.<TeleportDestination>;
      
      private var _destinationstree:FuncTree;
      
      public function TeleportDestinationsMessage()
      {
         this.destinations = new Vector.<TeleportDestination>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7615;
      }
      
      public function initTeleportDestinationsMessage(type:uint = 0, destinations:Vector.<TeleportDestination> = null) : TeleportDestinationsMessage
      {
         this.type = type;
         this.destinations = destinations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
         this.destinations = new Vector.<TeleportDestination>();
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
         this.serializeAs_TeleportDestinationsMessage(output);
      }
      
      public function serializeAs_TeleportDestinationsMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
         output.writeShort(this.destinations.length);
         for(var _i2:uint = 0; _i2 < this.destinations.length; _i2++)
         {
            (this.destinations[_i2] as TeleportDestination).serializeAs_TeleportDestination(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportDestinationsMessage(input);
      }
      
      public function deserializeAs_TeleportDestinationsMessage(input:ICustomDataInput) : void
      {
         var _item2:TeleportDestination = null;
         this._typeFunc(input);
         var _destinationsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _destinationsLen; _i2++)
         {
            _item2 = new TeleportDestination();
            _item2.deserialize(input);
            this.destinations.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportDestinationsMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportDestinationsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
         this._destinationstree = tree.addChild(this._destinationstreeFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of TeleportDestinationsMessage.type.");
         }
      }
      
      private function _destinationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._destinationstree.addChild(this._destinationsFunc);
         }
      }
      
      private function _destinationsFunc(input:ICustomDataInput) : void
      {
         var _item:TeleportDestination = new TeleportDestination();
         _item.deserialize(input);
         this.destinations.push(_item);
      }
   }
}
