package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StatedMapUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5303;
       
      
      private var _isInitialized:Boolean = false;
      
      public var statedElements:Vector.<StatedElement>;
      
      private var _statedElementstree:FuncTree;
      
      public function StatedMapUpdateMessage()
      {
         this.statedElements = new Vector.<StatedElement>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5303;
      }
      
      public function initStatedMapUpdateMessage(statedElements:Vector.<StatedElement> = null) : StatedMapUpdateMessage
      {
         this.statedElements = statedElements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.statedElements = new Vector.<StatedElement>();
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
         this.serializeAs_StatedMapUpdateMessage(output);
      }
      
      public function serializeAs_StatedMapUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.statedElements.length);
         for(var _i1:uint = 0; _i1 < this.statedElements.length; _i1++)
         {
            (this.statedElements[_i1] as StatedElement).serializeAs_StatedElement(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StatedMapUpdateMessage(input);
      }
      
      public function deserializeAs_StatedMapUpdateMessage(input:ICustomDataInput) : void
      {
         var _item1:StatedElement = null;
         var _statedElementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _statedElementsLen; _i1++)
         {
            _item1 = new StatedElement();
            _item1.deserialize(input);
            this.statedElements.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StatedMapUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_StatedMapUpdateMessage(tree:FuncTree) : void
      {
         this._statedElementstree = tree.addChild(this._statedElementstreeFunc);
      }
      
      private function _statedElementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._statedElementstree.addChild(this._statedElementsFunc);
         }
      }
      
      private function _statedElementsFunc(input:ICustomDataInput) : void
      {
         var _item:StatedElement = new StatedElement();
         _item.deserialize(input);
         this.statedElements.push(_item);
      }
   }
}
