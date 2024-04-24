package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightTurnListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8496;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ids:Vector.<Number>;
      
      public var deadsIds:Vector.<Number>;
      
      private var _idstree:FuncTree;
      
      private var _deadsIdstree:FuncTree;
      
      public function GameFightTurnListMessage()
      {
         this.ids = new Vector.<Number>();
         this.deadsIds = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8496;
      }
      
      public function initGameFightTurnListMessage(ids:Vector.<Number> = null, deadsIds:Vector.<Number> = null) : GameFightTurnListMessage
      {
         this.ids = ids;
         this.deadsIds = deadsIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ids = new Vector.<Number>();
         this.deadsIds = new Vector.<Number>();
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
         this.serializeAs_GameFightTurnListMessage(output);
      }
      
      public function serializeAs_GameFightTurnListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.ids.length);
         for(var _i1:uint = 0; _i1 < this.ids.length; _i1++)
         {
            if(this.ids[_i1] < -9007199254740992 || this.ids[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.ids[_i1] + ") on element 1 (starting at 1) of ids.");
            }
            output.writeDouble(this.ids[_i1]);
         }
         output.writeShort(this.deadsIds.length);
         for(var _i2:uint = 0; _i2 < this.deadsIds.length; _i2++)
         {
            if(this.deadsIds[_i2] < -9007199254740992 || this.deadsIds[_i2] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.deadsIds[_i2] + ") on element 2 (starting at 1) of deadsIds.");
            }
            output.writeDouble(this.deadsIds[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTurnListMessage(input);
      }
      
      public function deserializeAs_GameFightTurnListMessage(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         var _val2:Number = NaN;
         var _idsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _idsLen; _i1++)
         {
            _val1 = input.readDouble();
            if(_val1 < -9007199254740992 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of ids.");
            }
            this.ids.push(_val1);
         }
         var _deadsIdsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _deadsIdsLen; _i2++)
         {
            _val2 = input.readDouble();
            if(_val2 < -9007199254740992 || _val2 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of deadsIds.");
            }
            this.deadsIds.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightTurnListMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightTurnListMessage(tree:FuncTree) : void
      {
         this._idstree = tree.addChild(this._idstreeFunc);
         this._deadsIdstree = tree.addChild(this._deadsIdstreeFunc);
      }
      
      private function _idstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._idstree.addChild(this._idsFunc);
         }
      }
      
      private function _idsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < -9007199254740992 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ids.");
         }
         this.ids.push(_val);
      }
      
      private function _deadsIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._deadsIdstree.addChild(this._deadsIdsFunc);
         }
      }
      
      private function _deadsIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < -9007199254740992 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of deadsIds.");
         }
         this.deadsIds.push(_val);
      }
   }
}
