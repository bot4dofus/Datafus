package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameMapMovementRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4548;
       
      
      private var _isInitialized:Boolean = false;
      
      public var keyMovements:Vector.<uint>;
      
      public var mapId:Number = 0;
      
      private var _keyMovementstree:FuncTree;
      
      public function GameMapMovementRequestMessage()
      {
         this.keyMovements = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4548;
      }
      
      public function initGameMapMovementRequestMessage(keyMovements:Vector.<uint> = null, mapId:Number = 0) : GameMapMovementRequestMessage
      {
         this.keyMovements = keyMovements;
         this.mapId = mapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.keyMovements = new Vector.<uint>();
         this.mapId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_GameMapMovementRequestMessage(output);
      }
      
      public function serializeAs_GameMapMovementRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.keyMovements.length);
         for(var _i1:uint = 0; _i1 < this.keyMovements.length; _i1++)
         {
            if(this.keyMovements[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.keyMovements[_i1] + ") on element 1 (starting at 1) of keyMovements.");
            }
            output.writeShort(this.keyMovements[_i1]);
         }
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapMovementRequestMessage(input);
      }
      
      public function deserializeAs_GameMapMovementRequestMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _keyMovementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _keyMovementsLen; _i1++)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of keyMovements.");
            }
            this.keyMovements.push(_val1);
         }
         this._mapIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameMapMovementRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameMapMovementRequestMessage(tree:FuncTree) : void
      {
         this._keyMovementstree = tree.addChild(this._keyMovementstreeFunc);
         tree.addChild(this._mapIdFunc);
      }
      
      private function _keyMovementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._keyMovementstree.addChild(this._keyMovementsFunc);
         }
      }
      
      private function _keyMovementsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of keyMovements.");
         }
         this.keyMovements.push(_val);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of GameMapMovementRequestMessage.mapId.");
         }
      }
   }
}
