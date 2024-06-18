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
   
   public class GameActionItemAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8509;
       
      
      private var _isInitialized:Boolean = false;
      
      public var newAction:GameActionItem;
      
      private var _newActiontree:FuncTree;
      
      public function GameActionItemAddMessage()
      {
         this.newAction = new GameActionItem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8509;
      }
      
      public function initGameActionItemAddMessage(newAction:GameActionItem = null) : GameActionItemAddMessage
      {
         this.newAction = newAction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newAction = new GameActionItem();
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
         this.serializeAs_GameActionItemAddMessage(output);
      }
      
      public function serializeAs_GameActionItemAddMessage(output:ICustomDataOutput) : void
      {
         this.newAction.serializeAs_GameActionItem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionItemAddMessage(input);
      }
      
      public function deserializeAs_GameActionItemAddMessage(input:ICustomDataInput) : void
      {
         this.newAction = new GameActionItem();
         this.newAction.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionItemAddMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionItemAddMessage(tree:FuncTree) : void
      {
         this._newActiontree = tree.addChild(this._newActiontreeFunc);
      }
      
      private function _newActiontreeFunc(input:ICustomDataInput) : void
      {
         this.newAction = new GameActionItem();
         this.newAction.deserializeAsync(this._newActiontree);
      }
   }
}
