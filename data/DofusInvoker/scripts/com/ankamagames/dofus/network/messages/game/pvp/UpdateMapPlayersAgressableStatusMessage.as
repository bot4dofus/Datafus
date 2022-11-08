package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateMapPlayersAgressableStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9068;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerIds:Vector.<Number>;
      
      public var enable:Vector.<uint>;
      
      private var _playerIdstree:FuncTree;
      
      private var _enabletree:FuncTree;
      
      public function UpdateMapPlayersAgressableStatusMessage()
      {
         this.playerIds = new Vector.<Number>();
         this.enable = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9068;
      }
      
      public function initUpdateMapPlayersAgressableStatusMessage(playerIds:Vector.<Number> = null, enable:Vector.<uint> = null) : UpdateMapPlayersAgressableStatusMessage
      {
         this.playerIds = playerIds;
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerIds = new Vector.<Number>();
         this.enable = new Vector.<uint>();
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
         this.serializeAs_UpdateMapPlayersAgressableStatusMessage(output);
      }
      
      public function serializeAs_UpdateMapPlayersAgressableStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.playerIds.length);
         for(var _i1:uint = 0; _i1 < this.playerIds.length; _i1++)
         {
            if(this.playerIds[_i1] < 0 || this.playerIds[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.playerIds[_i1] + ") on element 1 (starting at 1) of playerIds.");
            }
            output.writeVarLong(this.playerIds[_i1]);
         }
         output.writeShort(this.enable.length);
         for(var _i2:uint = 0; _i2 < this.enable.length; _i2++)
         {
            output.writeByte(this.enable[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMapPlayersAgressableStatusMessage(input);
      }
      
      public function deserializeAs_UpdateMapPlayersAgressableStatusMessage(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         var _val2:uint = 0;
         var _playerIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _playerIdsLen; _i1++)
         {
            _val1 = input.readVarUhLong();
            if(_val1 < 0 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of playerIds.");
            }
            this.playerIds.push(_val1);
         }
         var _enableLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _enableLen; _i2++)
         {
            _val2 = input.readByte();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of enable.");
            }
            this.enable.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateMapPlayersAgressableStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateMapPlayersAgressableStatusMessage(tree:FuncTree) : void
      {
         this._playerIdstree = tree.addChild(this._playerIdstreeFunc);
         this._enabletree = tree.addChild(this._enabletreeFunc);
      }
      
      private function _playerIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._playerIdstree.addChild(this._playerIdsFunc);
         }
      }
      
      private function _playerIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readVarUhLong();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of playerIds.");
         }
         this.playerIds.push(_val);
      }
      
      private function _enabletreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._enabletree.addChild(this._enableFunc);
         }
      }
      
      private function _enableFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of enable.");
         }
         this.enable.push(_val);
      }
   }
}
