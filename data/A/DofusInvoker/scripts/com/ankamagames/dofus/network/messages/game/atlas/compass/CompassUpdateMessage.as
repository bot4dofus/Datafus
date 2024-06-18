package com.ankamagames.dofus.network.messages.game.atlas.compass
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CompassUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 872;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public var coords:MapCoordinates;
      
      private var _coordstree:FuncTree;
      
      public function CompassUpdateMessage()
      {
         this.coords = new MapCoordinates();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 872;
      }
      
      public function initCompassUpdateMessage(type:uint = 0, coords:MapCoordinates = null) : CompassUpdateMessage
      {
         this.type = type;
         this.coords = coords;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
         this.coords = new MapCoordinates();
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
         this.serializeAs_CompassUpdateMessage(output);
      }
      
      public function serializeAs_CompassUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
         output.writeShort(this.coords.getTypeId());
         this.coords.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CompassUpdateMessage(input);
      }
      
      public function deserializeAs_CompassUpdateMessage(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.coords = ProtocolTypeManager.getInstance(MapCoordinates,_id2);
         this.coords.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CompassUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_CompassUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
         this._coordstree = tree.addChild(this._coordstreeFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CompassUpdateMessage.type.");
         }
      }
      
      private function _coordstreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.coords = ProtocolTypeManager.getInstance(MapCoordinates,_id);
         this.coords.deserializeAsync(this._coordstree);
      }
   }
}
