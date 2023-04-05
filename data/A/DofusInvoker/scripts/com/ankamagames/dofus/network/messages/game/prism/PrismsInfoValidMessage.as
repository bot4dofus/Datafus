package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismsInfoValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9792;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fights:Vector.<PrismFightersInformation>;
      
      private var _fightstree:FuncTree;
      
      public function PrismsInfoValidMessage()
      {
         this.fights = new Vector.<PrismFightersInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9792;
      }
      
      public function initPrismsInfoValidMessage(fights:Vector.<PrismFightersInformation> = null) : PrismsInfoValidMessage
      {
         this.fights = fights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fights = new Vector.<PrismFightersInformation>();
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
         this.serializeAs_PrismsInfoValidMessage(output);
      }
      
      public function serializeAs_PrismsInfoValidMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.fights.length);
         for(var _i1:uint = 0; _i1 < this.fights.length; _i1++)
         {
            (this.fights[_i1] as PrismFightersInformation).serializeAs_PrismFightersInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismsInfoValidMessage(input);
      }
      
      public function deserializeAs_PrismsInfoValidMessage(input:ICustomDataInput) : void
      {
         var _item1:PrismFightersInformation = null;
         var _fightsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _fightsLen; _i1++)
         {
            _item1 = new PrismFightersInformation();
            _item1.deserialize(input);
            this.fights.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismsInfoValidMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismsInfoValidMessage(tree:FuncTree) : void
      {
         this._fightstree = tree.addChild(this._fightstreeFunc);
      }
      
      private function _fightstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fightstree.addChild(this._fightsFunc);
         }
      }
      
      private function _fightsFunc(input:ICustomDataInput) : void
      {
         var _item:PrismFightersInformation = new PrismFightersInformation();
         _item.deserialize(input);
         this.fights.push(_item);
      }
   }
}
