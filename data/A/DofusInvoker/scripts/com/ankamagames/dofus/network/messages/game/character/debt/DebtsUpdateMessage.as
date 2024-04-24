package com.ankamagames.dofus.network.messages.game.character.debt
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.debt.DebtInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DebtsUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3509;
       
      
      private var _isInitialized:Boolean = false;
      
      public var action:uint = 0;
      
      public var debts:Vector.<DebtInformation>;
      
      private var _debtstree:FuncTree;
      
      public function DebtsUpdateMessage()
      {
         this.debts = new Vector.<DebtInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3509;
      }
      
      public function initDebtsUpdateMessage(action:uint = 0, debts:Vector.<DebtInformation> = null) : DebtsUpdateMessage
      {
         this.action = action;
         this.debts = debts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.action = 0;
         this.debts = new Vector.<DebtInformation>();
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
         this.serializeAs_DebtsUpdateMessage(output);
      }
      
      public function serializeAs_DebtsUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.action);
         output.writeShort(this.debts.length);
         for(var _i2:uint = 0; _i2 < this.debts.length; _i2++)
         {
            output.writeShort((this.debts[_i2] as DebtInformation).getTypeId());
            (this.debts[_i2] as DebtInformation).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DebtsUpdateMessage(input);
      }
      
      public function deserializeAs_DebtsUpdateMessage(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:DebtInformation = null;
         this._actionFunc(input);
         var _debtsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _debtsLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(DebtInformation,_id2);
            _item2.deserialize(input);
            this.debts.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DebtsUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_DebtsUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actionFunc);
         this._debtstree = tree.addChild(this._debtstreeFunc);
      }
      
      private function _actionFunc(input:ICustomDataInput) : void
      {
         this.action = input.readByte();
         if(this.action < 0)
         {
            throw new Error("Forbidden value (" + this.action + ") on element of DebtsUpdateMessage.action.");
         }
      }
      
      private function _debtstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._debtstree.addChild(this._debtsFunc);
         }
      }
      
      private function _debtsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:DebtInformation = ProtocolTypeManager.getInstance(DebtInformation,_id);
         _item.deserialize(input);
         this.debts.push(_item);
      }
   }
}
