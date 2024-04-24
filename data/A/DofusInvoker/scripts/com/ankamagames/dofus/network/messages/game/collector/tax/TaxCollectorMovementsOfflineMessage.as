package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorMovement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorMovementsOfflineMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8947;
       
      
      private var _isInitialized:Boolean = false;
      
      public var movements:Vector.<TaxCollectorMovement>;
      
      private var _movementstree:FuncTree;
      
      public function TaxCollectorMovementsOfflineMessage()
      {
         this.movements = new Vector.<TaxCollectorMovement>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8947;
      }
      
      public function initTaxCollectorMovementsOfflineMessage(movements:Vector.<TaxCollectorMovement> = null) : TaxCollectorMovementsOfflineMessage
      {
         this.movements = movements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.movements = new Vector.<TaxCollectorMovement>();
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
         this.serializeAs_TaxCollectorMovementsOfflineMessage(output);
      }
      
      public function serializeAs_TaxCollectorMovementsOfflineMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.movements.length);
         for(var _i1:uint = 0; _i1 < this.movements.length; _i1++)
         {
            (this.movements[_i1] as TaxCollectorMovement).serializeAs_TaxCollectorMovement(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorMovementsOfflineMessage(input);
      }
      
      public function deserializeAs_TaxCollectorMovementsOfflineMessage(input:ICustomDataInput) : void
      {
         var _item1:TaxCollectorMovement = null;
         var _movementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _movementsLen; _i1++)
         {
            _item1 = new TaxCollectorMovement();
            _item1.deserialize(input);
            this.movements.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorMovementsOfflineMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorMovementsOfflineMessage(tree:FuncTree) : void
      {
         this._movementstree = tree.addChild(this._movementstreeFunc);
      }
      
      private function _movementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._movementstree.addChild(this._movementsFunc);
         }
      }
      
      private function _movementsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorMovement = new TaxCollectorMovement();
         _item.deserialize(input);
         this.movements.push(_item);
      }
   }
}
