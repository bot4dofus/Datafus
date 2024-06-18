package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AccountHouseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7345;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houses:Vector.<AccountHouseInformations>;
      
      private var _housestree:FuncTree;
      
      public function AccountHouseMessage()
      {
         this.houses = new Vector.<AccountHouseInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7345;
      }
      
      public function initAccountHouseMessage(houses:Vector.<AccountHouseInformations> = null) : AccountHouseMessage
      {
         this.houses = houses;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houses = new Vector.<AccountHouseInformations>();
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
         this.serializeAs_AccountHouseMessage(output);
      }
      
      public function serializeAs_AccountHouseMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.houses.length);
         for(var _i1:uint = 0; _i1 < this.houses.length; _i1++)
         {
            (this.houses[_i1] as AccountHouseInformations).serializeAs_AccountHouseInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccountHouseMessage(input);
      }
      
      public function deserializeAs_AccountHouseMessage(input:ICustomDataInput) : void
      {
         var _item1:AccountHouseInformations = null;
         var _housesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _housesLen; _i1++)
         {
            _item1 = new AccountHouseInformations();
            _item1.deserialize(input);
            this.houses.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccountHouseMessage(tree);
      }
      
      public function deserializeAsyncAs_AccountHouseMessage(tree:FuncTree) : void
      {
         this._housestree = tree.addChild(this._housestreeFunc);
      }
      
      private function _housestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._housestree.addChild(this._housesFunc);
         }
      }
      
      private function _housesFunc(input:ICustomDataInput) : void
      {
         var _item:AccountHouseInformations = new AccountHouseInformations();
         _item.deserialize(input);
         this.houses.push(_item);
      }
   }
}
