package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7733;
       
      
      private var _isInitialized:Boolean = false;
      
      public var prisms:Vector.<PrismGeolocalizedInformation>;
      
      private var _prismstree:FuncTree;
      
      public function PrismsListMessage()
      {
         this.prisms = new Vector.<PrismGeolocalizedInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7733;
      }
      
      public function initPrismsListMessage(prisms:Vector.<PrismGeolocalizedInformation> = null) : PrismsListMessage
      {
         this.prisms = prisms;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.prisms = new Vector.<PrismGeolocalizedInformation>();
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
         this.serializeAs_PrismsListMessage(output);
      }
      
      public function serializeAs_PrismsListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.prisms.length);
         for(var _i1:uint = 0; _i1 < this.prisms.length; _i1++)
         {
            output.writeShort((this.prisms[_i1] as PrismGeolocalizedInformation).getTypeId());
            (this.prisms[_i1] as PrismGeolocalizedInformation).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismsListMessage(input);
      }
      
      public function deserializeAs_PrismsListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:PrismGeolocalizedInformation = null;
         var _prismsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _prismsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(PrismGeolocalizedInformation,_id1);
            _item1.deserialize(input);
            this.prisms.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismsListMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismsListMessage(tree:FuncTree) : void
      {
         this._prismstree = tree.addChild(this._prismstreeFunc);
      }
      
      private function _prismstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._prismstree.addChild(this._prismsFunc);
         }
      }
      
      private function _prismsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:PrismGeolocalizedInformation = ProtocolTypeManager.getInstance(PrismGeolocalizedInformation,_id);
         _item.deserialize(input);
         this.prisms.push(_item);
      }
   }
}
