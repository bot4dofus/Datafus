package com.ankamagames.dofus.network.messages.game.character.spell.forgettable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ForgettableSpellClientActionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5459;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public var action:uint = 0;
      
      public function ForgettableSpellClientActionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5459;
      }
      
      public function initForgettableSpellClientActionMessage(spellId:uint = 0, action:uint = 0) : ForgettableSpellClientActionMessage
      {
         this.spellId = spellId;
         this.action = action;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.action = 0;
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
         this.serializeAs_ForgettableSpellClientActionMessage(output);
      }
      
      public function serializeAs_ForgettableSpellClientActionMessage(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeInt(this.spellId);
         output.writeByte(this.action);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForgettableSpellClientActionMessage(input);
      }
      
      public function deserializeAs_ForgettableSpellClientActionMessage(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._actionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForgettableSpellClientActionMessage(tree);
      }
      
      public function deserializeAsyncAs_ForgettableSpellClientActionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._actionFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readInt();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of ForgettableSpellClientActionMessage.spellId.");
         }
      }
      
      private function _actionFunc(input:ICustomDataInput) : void
      {
         this.action = input.readByte();
         if(this.action < 0)
         {
            throw new Error("Forbidden value (" + this.action + ") on element of ForgettableSpellClientActionMessage.action.");
         }
      }
   }
}
