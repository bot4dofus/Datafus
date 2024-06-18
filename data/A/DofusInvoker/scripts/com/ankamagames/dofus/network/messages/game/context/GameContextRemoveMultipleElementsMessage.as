package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameContextRemoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5405;
       
      
      private var _isInitialized:Boolean = false;
      
      public var elementsIds:Vector.<Number>;
      
      private var _elementsIdstree:FuncTree;
      
      public function GameContextRemoveMultipleElementsMessage()
      {
         this.elementsIds = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5405;
      }
      
      public function initGameContextRemoveMultipleElementsMessage(elementsIds:Vector.<Number> = null) : GameContextRemoveMultipleElementsMessage
      {
         this.elementsIds = elementsIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.elementsIds = new Vector.<Number>();
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
         this.serializeAs_GameContextRemoveMultipleElementsMessage(output);
      }
      
      public function serializeAs_GameContextRemoveMultipleElementsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.elementsIds.length);
         for(var _i1:uint = 0; _i1 < this.elementsIds.length; _i1++)
         {
            if(this.elementsIds[_i1] < -9007199254740992 || this.elementsIds[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.elementsIds[_i1] + ") on element 1 (starting at 1) of elementsIds.");
            }
            output.writeDouble(this.elementsIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextRemoveMultipleElementsMessage(input);
      }
      
      public function deserializeAs_GameContextRemoveMultipleElementsMessage(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         var _elementsIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _elementsIdsLen; _i1++)
         {
            _val1 = input.readDouble();
            if(_val1 < -9007199254740992 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of elementsIds.");
            }
            this.elementsIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextRemoveMultipleElementsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameContextRemoveMultipleElementsMessage(tree:FuncTree) : void
      {
         this._elementsIdstree = tree.addChild(this._elementsIdstreeFunc);
      }
      
      private function _elementsIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._elementsIdstree.addChild(this._elementsIdsFunc);
         }
      }
      
      private function _elementsIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < -9007199254740992 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of elementsIds.");
         }
         this.elementsIds.push(_val);
      }
   }
}
