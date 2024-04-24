package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemGenericQuantity;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeTaxCollectorGetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2438;
       
      
      private var _isInitialized:Boolean = false;
      
      public var collectorName:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var userName:String = "";
      
      public var callerId:Number = 0;
      
      public var callerName:String = "";
      
      public var pods:uint = 0;
      
      public var objectsInfos:Vector.<ObjectItemGenericQuantity>;
      
      public var look:EntityLook;
      
      private var _objectsInfostree:FuncTree;
      
      private var _looktree:FuncTree;
      
      public function ExchangeTaxCollectorGetMessage()
      {
         this.objectsInfos = new Vector.<ObjectItemGenericQuantity>();
         this.look = new EntityLook();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2438;
      }
      
      public function initExchangeTaxCollectorGetMessage(collectorName:String = "", worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, userName:String = "", callerId:Number = 0, callerName:String = "", pods:uint = 0, objectsInfos:Vector.<ObjectItemGenericQuantity> = null, look:EntityLook = null) : ExchangeTaxCollectorGetMessage
      {
         this.collectorName = collectorName;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.userName = userName;
         this.callerId = callerId;
         this.callerName = callerName;
         this.pods = pods;
         this.objectsInfos = objectsInfos;
         this.look = look;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.collectorName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.userName = "";
         this.callerId = 0;
         this.callerName = "";
         this.pods = 0;
         this.objectsInfos = new Vector.<ObjectItemGenericQuantity>();
         this.look = new EntityLook();
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
         this.serializeAs_ExchangeTaxCollectorGetMessage(output);
      }
      
      public function serializeAs_ExchangeTaxCollectorGetMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.collectorName);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeUTF(this.userName);
         if(this.callerId < 0 || this.callerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.callerId + ") on element callerId.");
         }
         output.writeVarLong(this.callerId);
         output.writeUTF(this.callerName);
         if(this.pods < 0)
         {
            throw new Error("Forbidden value (" + this.pods + ") on element pods.");
         }
         output.writeVarShort(this.pods);
         output.writeShort(this.objectsInfos.length);
         for(var _i10:uint = 0; _i10 < this.objectsInfos.length; _i10++)
         {
            (this.objectsInfos[_i10] as ObjectItemGenericQuantity).serializeAs_ObjectItemGenericQuantity(output);
         }
         this.look.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeTaxCollectorGetMessage(input);
      }
      
      public function deserializeAs_ExchangeTaxCollectorGetMessage(input:ICustomDataInput) : void
      {
         var _item10:ObjectItemGenericQuantity = null;
         this._collectorNameFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         this._userNameFunc(input);
         this._callerIdFunc(input);
         this._callerNameFunc(input);
         this._podsFunc(input);
         var _objectsInfosLen:uint = input.readUnsignedShort();
         for(var _i10:uint = 0; _i10 < _objectsInfosLen; _i10++)
         {
            _item10 = new ObjectItemGenericQuantity();
            _item10.deserialize(input);
            this.objectsInfos.push(_item10);
         }
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeTaxCollectorGetMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeTaxCollectorGetMessage(tree:FuncTree) : void
      {
         tree.addChild(this._collectorNameFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._userNameFunc);
         tree.addChild(this._callerIdFunc);
         tree.addChild(this._callerNameFunc);
         tree.addChild(this._podsFunc);
         this._objectsInfostree = tree.addChild(this._objectsInfostreeFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
      }
      
      private function _collectorNameFunc(input:ICustomDataInput) : void
      {
         this.collectorName = input.readUTF();
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeTaxCollectorGetMessage.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeTaxCollectorGetMessage.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of ExchangeTaxCollectorGetMessage.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of ExchangeTaxCollectorGetMessage.subAreaId.");
         }
      }
      
      private function _userNameFunc(input:ICustomDataInput) : void
      {
         this.userName = input.readUTF();
      }
      
      private function _callerIdFunc(input:ICustomDataInput) : void
      {
         this.callerId = input.readVarUhLong();
         if(this.callerId < 0 || this.callerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.callerId + ") on element of ExchangeTaxCollectorGetMessage.callerId.");
         }
      }
      
      private function _callerNameFunc(input:ICustomDataInput) : void
      {
         this.callerName = input.readUTF();
      }
      
      private function _podsFunc(input:ICustomDataInput) : void
      {
         this.pods = input.readVarUhShort();
         if(this.pods < 0)
         {
            throw new Error("Forbidden value (" + this.pods + ") on element of ExchangeTaxCollectorGetMessage.pods.");
         }
      }
      
      private function _objectsInfostreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectsInfostree.addChild(this._objectsInfosFunc);
         }
      }
      
      private function _objectsInfosFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemGenericQuantity = new ObjectItemGenericQuantity();
         _item.deserialize(input);
         this.objectsInfos.push(_item);
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
