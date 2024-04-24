package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightDispellSpellMessage extends GameActionFightDispellMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1119;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public function GameActionFightDispellSpellMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1119;
      }
      
      public function initGameActionFightDispellSpellMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, verboseCast:Boolean = false, spellId:uint = 0) : GameActionFightDispellSpellMessage
      {
         super.initGameActionFightDispellMessage(actionId,sourceId,targetId,verboseCast);
         this.spellId = spellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spellId = 0;
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
         this.serializeAs_GameActionFightDispellSpellMessage(output);
      }
      
      public function serializeAs_GameActionFightDispellSpellMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameActionFightDispellMessage(output);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightDispellSpellMessage(input);
      }
      
      public function deserializeAs_GameActionFightDispellSpellMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._spellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightDispellSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightDispellSpellMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._spellIdFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightDispellSpellMessage.spellId.");
         }
      }
   }
}
