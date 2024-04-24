package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AcquaintancesListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1541;
       
      
      private var _isInitialized:Boolean = false;
      
      public var acquaintanceList:Vector.<AcquaintanceInformation>;
      
      private var _acquaintanceListtree:FuncTree;
      
      public function AcquaintancesListMessage()
      {
         this.acquaintanceList = new Vector.<AcquaintanceInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1541;
      }
      
      public function initAcquaintancesListMessage(acquaintanceList:Vector.<AcquaintanceInformation> = null) : AcquaintancesListMessage
      {
         this.acquaintanceList = acquaintanceList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.acquaintanceList = new Vector.<AcquaintanceInformation>();
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
         this.serializeAs_AcquaintancesListMessage(output);
      }
      
      public function serializeAs_AcquaintancesListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.acquaintanceList.length);
         for(var _i1:uint = 0; _i1 < this.acquaintanceList.length; _i1++)
         {
            output.writeShort((this.acquaintanceList[_i1] as AcquaintanceInformation).getTypeId());
            (this.acquaintanceList[_i1] as AcquaintanceInformation).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintancesListMessage(input);
      }
      
      public function deserializeAs_AcquaintancesListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:AcquaintanceInformation = null;
         var _acquaintanceListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _acquaintanceListLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(AcquaintanceInformation,_id1);
            _item1.deserialize(input);
            this.acquaintanceList.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AcquaintancesListMessage(tree);
      }
      
      public function deserializeAsyncAs_AcquaintancesListMessage(tree:FuncTree) : void
      {
         this._acquaintanceListtree = tree.addChild(this._acquaintanceListtreeFunc);
      }
      
      private function _acquaintanceListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._acquaintanceListtree.addChild(this._acquaintanceListFunc);
         }
      }
      
      private function _acquaintanceListFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:AcquaintanceInformation = ProtocolTypeManager.getInstance(AcquaintanceInformation,_id);
         _item.deserialize(input);
         this.acquaintanceList.push(_item);
      }
   }
}
