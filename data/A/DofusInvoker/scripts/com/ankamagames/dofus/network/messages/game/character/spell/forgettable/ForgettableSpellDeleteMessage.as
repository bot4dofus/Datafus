package com.ankamagames.dofus.network.messages.game.character.spell.forgettable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ForgettableSpellDeleteMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4817;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:uint = 0;
      
      public var spells:Vector.<uint>;
      
      private var _spellstree:FuncTree;
      
      public function ForgettableSpellDeleteMessage()
      {
         this.spells = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4817;
      }
      
      public function initForgettableSpellDeleteMessage(reason:uint = 0, spells:Vector.<uint> = null) : ForgettableSpellDeleteMessage
      {
         this.reason = reason;
         this.spells = spells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.reason = 0;
         this.spells = new Vector.<uint>();
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
         this.serializeAs_ForgettableSpellDeleteMessage(output);
      }
      
      public function serializeAs_ForgettableSpellDeleteMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.reason);
         output.writeShort(this.spells.length);
         for(var _i2:uint = 0; _i2 < this.spells.length; _i2++)
         {
            if(this.spells[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.spells[_i2] + ") on element 2 (starting at 1) of spells.");
            }
            output.writeInt(this.spells[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForgettableSpellDeleteMessage(input);
      }
      
      public function deserializeAs_ForgettableSpellDeleteMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._reasonFunc(input);
         var _spellsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _spellsLen; _i2++)
         {
            _val2 = input.readInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of spells.");
            }
            this.spells.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForgettableSpellDeleteMessage(tree);
      }
      
      public function deserializeAsyncAs_ForgettableSpellDeleteMessage(tree:FuncTree) : void
      {
         tree.addChild(this._reasonFunc);
         this._spellstree = tree.addChild(this._spellstreeFunc);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of ForgettableSpellDeleteMessage.reason.");
         }
      }
      
      private function _spellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellstree.addChild(this._spellsFunc);
         }
      }
      
      private function _spellsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of spells.");
         }
         this.spells.push(_val);
      }
   }
}
