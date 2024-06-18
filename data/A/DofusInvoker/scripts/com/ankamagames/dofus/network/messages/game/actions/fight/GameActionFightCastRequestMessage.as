package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightCastRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6438;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public var cellId:int = 0;
      
      public function GameActionFightCastRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6438;
      }
      
      public function initGameActionFightCastRequestMessage(spellId:uint = 0, cellId:int = 0) : GameActionFightCastRequestMessage
      {
         this.spellId = spellId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.cellId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_GameActionFightCastRequestMessage(output);
      }
      
      public function serializeAs_GameActionFightCastRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         if(this.cellId < -1 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeShort(this.cellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightCastRequestMessage(input);
      }
      
      public function deserializeAs_GameActionFightCastRequestMessage(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._cellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightCastRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightCastRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._cellIdFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastRequestMessage.spellId.");
         }
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readShort();
         if(this.cellId < -1 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionFightCastRequestMessage.cellId.");
         }
      }
   }
}
