package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.dofus.network.types.game.startup.GameActionItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionItemListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4354;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actions:Vector.<GameActionItem>;
      
      private var _actionstree:FuncTree;
      
      public function GameActionItemListMessage()
      {
         this.actions = new Vector.<GameActionItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4354;
      }
      
      public function initGameActionItemListMessage(actions:Vector.<GameActionItem> = null) : GameActionItemListMessage
      {
         this.actions = actions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actions = new Vector.<GameActionItem>();
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
         this.serializeAs_GameActionItemListMessage(output);
      }
      
      public function serializeAs_GameActionItemListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.actions.length);
         for(var _i1:uint = 0; _i1 < this.actions.length; _i1++)
         {
            (this.actions[_i1] as GameActionItem).serializeAs_GameActionItem(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionItemListMessage(input);
      }
      
      public function deserializeAs_GameActionItemListMessage(input:ICustomDataInput) : void
      {
         var _item1:GameActionItem = null;
         var _actionsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _actionsLen; _i1++)
         {
            _item1 = new GameActionItem();
            _item1.deserialize(input);
            this.actions.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionItemListMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionItemListMessage(tree:FuncTree) : void
      {
         this._actionstree = tree.addChild(this._actionstreeFunc);
      }
      
      private function _actionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._actionstree.addChild(this._actionsFunc);
         }
      }
      
      private function _actionsFunc(input:ICustomDataInput) : void
      {
         var _item:GameActionItem = new GameActionItem();
         _item.deserialize(input);
         this.actions.push(_item);
      }
   }
}
