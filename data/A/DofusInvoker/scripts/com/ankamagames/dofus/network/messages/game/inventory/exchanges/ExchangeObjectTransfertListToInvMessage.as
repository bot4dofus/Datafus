package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectTransfertListToInvMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7242;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ids:Vector.<uint>;
      
      private var _idstree:FuncTree;
      
      public function ExchangeObjectTransfertListToInvMessage()
      {
         this.ids = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7242;
      }
      
      public function initExchangeObjectTransfertListToInvMessage(ids:Vector.<uint> = null) : ExchangeObjectTransfertListToInvMessage
      {
         this.ids = ids;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ids = new Vector.<uint>();
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
         this.serializeAs_ExchangeObjectTransfertListToInvMessage(output);
      }
      
      public function serializeAs_ExchangeObjectTransfertListToInvMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.ids.length);
         for(var _i1:uint = 0; _i1 < this.ids.length; _i1++)
         {
            if(this.ids[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.ids[_i1] + ") on element 1 (starting at 1) of ids.");
            }
            output.writeVarInt(this.ids[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectTransfertListToInvMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectTransfertListToInvMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _idsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _idsLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of ids.");
            }
            this.ids.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectTransfertListToInvMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectTransfertListToInvMessage(tree:FuncTree) : void
      {
         this._idstree = tree.addChild(this._idstreeFunc);
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
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ids.");
         }
         this.ids.push(_val);
      }
   }
}
