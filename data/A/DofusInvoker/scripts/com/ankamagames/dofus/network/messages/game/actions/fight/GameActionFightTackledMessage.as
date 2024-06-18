package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightTackledMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3805;
       
      
      private var _isInitialized:Boolean = false;
      
      public var tacklersIds:Vector.<Number>;
      
      private var _tacklersIdstree:FuncTree;
      
      public function GameActionFightTackledMessage()
      {
         this.tacklersIds = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3805;
      }
      
      public function initGameActionFightTackledMessage(actionId:uint = 0, sourceId:Number = 0, tacklersIds:Vector.<Number> = null) : GameActionFightTackledMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.tacklersIds = tacklersIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.tacklersIds = new Vector.<Number>();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionFightTackledMessage(output);
      }
      
      public function serializeAs_GameActionFightTackledMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.tacklersIds.length);
         for(var _i1:uint = 0; _i1 < this.tacklersIds.length; _i1++)
         {
            if(this.tacklersIds[_i1] < -9007199254740992 || this.tacklersIds[_i1] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.tacklersIds[_i1] + ") on element 1 (starting at 1) of tacklersIds.");
            }
            output.writeDouble(this.tacklersIds[_i1]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightTackledMessage(input);
      }
      
      public function deserializeAs_GameActionFightTackledMessage(input:ICustomDataInput) : void
      {
         var _val1:Number = NaN;
         super.deserialize(input);
         var _tacklersIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _tacklersIdsLen; _i1++)
         {
            _val1 = input.readDouble();
            if(_val1 < -9007199254740992 || _val1 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of tacklersIds.");
            }
            this.tacklersIds.push(_val1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightTackledMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightTackledMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._tacklersIdstree = tree.addChild(this._tacklersIdstreeFunc);
      }
      
      private function _tacklersIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._tacklersIdstree.addChild(this._tacklersIdsFunc);
         }
      }
      
      private function _tacklersIdsFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < -9007199254740992 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of tacklersIds.");
         }
         this.tacklersIds.push(_val);
      }
   }
}
