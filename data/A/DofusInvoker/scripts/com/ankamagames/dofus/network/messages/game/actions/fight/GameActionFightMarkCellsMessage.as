package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightMarkCellsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 432;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mark:GameActionMark;
      
      private var _marktree:FuncTree;
      
      public function GameActionFightMarkCellsMessage()
      {
         this.mark = new GameActionMark();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 432;
      }
      
      public function initGameActionFightMarkCellsMessage(actionId:uint = 0, sourceId:Number = 0, mark:GameActionMark = null) : GameActionFightMarkCellsMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.mark = mark;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.mark = new GameActionMark();
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
         this.serializeAs_GameActionFightMarkCellsMessage(output);
      }
      
      public function serializeAs_GameActionFightMarkCellsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         this.mark.serializeAs_GameActionMark(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightMarkCellsMessage(input);
      }
      
      public function deserializeAs_GameActionFightMarkCellsMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.mark = new GameActionMark();
         this.mark.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightMarkCellsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightMarkCellsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._marktree = tree.addChild(this._marktreeFunc);
      }
      
      private function _marktreeFunc(input:ICustomDataInput) : void
      {
         this.mark = new GameActionMark();
         this.mark.deserializeAsync(this._marktree);
      }
   }
}
