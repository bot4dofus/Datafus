package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SlaveSwitchContextMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 974;
       
      
      private var _isInitialized:Boolean = false;
      
      public var masterId:Number = 0;
      
      public var slaveId:Number = 0;
      
      public var slaveTurn:uint = 0;
      
      public var slaveSpells:Vector.<SpellItem>;
      
      public var slaveStats:CharacterCharacteristicsInformations;
      
      public var shortcuts:Vector.<Shortcut>;
      
      private var _slaveSpellstree:FuncTree;
      
      private var _slaveStatstree:FuncTree;
      
      private var _shortcutstree:FuncTree;
      
      public function SlaveSwitchContextMessage()
      {
         this.slaveSpells = new Vector.<SpellItem>();
         this.slaveStats = new CharacterCharacteristicsInformations();
         this.shortcuts = new Vector.<Shortcut>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 974;
      }
      
      public function initSlaveSwitchContextMessage(masterId:Number = 0, slaveId:Number = 0, slaveTurn:uint = 0, slaveSpells:Vector.<SpellItem> = null, slaveStats:CharacterCharacteristicsInformations = null, shortcuts:Vector.<Shortcut> = null) : SlaveSwitchContextMessage
      {
         this.masterId = masterId;
         this.slaveId = slaveId;
         this.slaveTurn = slaveTurn;
         this.slaveSpells = slaveSpells;
         this.slaveStats = slaveStats;
         this.shortcuts = shortcuts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.masterId = 0;
         this.slaveId = 0;
         this.slaveTurn = 0;
         this.slaveSpells = new Vector.<SpellItem>();
         this.slaveStats = new CharacterCharacteristicsInformations();
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
         this.serializeAs_SlaveSwitchContextMessage(output);
      }
      
      public function serializeAs_SlaveSwitchContextMessage(output:ICustomDataOutput) : void
      {
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element masterId.");
         }
         output.writeDouble(this.masterId);
         if(this.slaveId < -9007199254740992 || this.slaveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.slaveId + ") on element slaveId.");
         }
         output.writeDouble(this.slaveId);
         if(this.slaveTurn < 0)
         {
            throw new Error("Forbidden value (" + this.slaveTurn + ") on element slaveTurn.");
         }
         output.writeVarShort(this.slaveTurn);
         output.writeShort(this.slaveSpells.length);
         for(var _i4:uint = 0; _i4 < this.slaveSpells.length; _i4++)
         {
            (this.slaveSpells[_i4] as SpellItem).serializeAs_SpellItem(output);
         }
         this.slaveStats.serializeAs_CharacterCharacteristicsInformations(output);
         output.writeShort(this.shortcuts.length);
         for(var _i6:uint = 0; _i6 < this.shortcuts.length; _i6++)
         {
            output.writeShort((this.shortcuts[_i6] as Shortcut).getTypeId());
            (this.shortcuts[_i6] as Shortcut).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SlaveSwitchContextMessage(input);
      }
      
      public function deserializeAs_SlaveSwitchContextMessage(input:ICustomDataInput) : void
      {
         var _item4:SpellItem = null;
         var _id6:uint = 0;
         var _item6:Shortcut = null;
         this._masterIdFunc(input);
         this._slaveIdFunc(input);
         this._slaveTurnFunc(input);
         var _slaveSpellsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _slaveSpellsLen; _i4++)
         {
            _item4 = new SpellItem();
            _item4.deserialize(input);
            this.slaveSpells.push(_item4);
         }
         this.slaveStats = new CharacterCharacteristicsInformations();
         this.slaveStats.deserialize(input);
         var _shortcutsLen:uint = input.readUnsignedShort();
         for(var _i6:uint = 0; _i6 < _shortcutsLen; _i6++)
         {
            _id6 = input.readUnsignedShort();
            _item6 = ProtocolTypeManager.getInstance(Shortcut,_id6);
            _item6.deserialize(input);
            this.shortcuts.push(_item6);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SlaveSwitchContextMessage(tree);
      }
      
      public function deserializeAsyncAs_SlaveSwitchContextMessage(tree:FuncTree) : void
      {
         tree.addChild(this._masterIdFunc);
         tree.addChild(this._slaveIdFunc);
         tree.addChild(this._slaveTurnFunc);
         this._slaveSpellstree = tree.addChild(this._slaveSpellstreeFunc);
         this._slaveStatstree = tree.addChild(this._slaveStatstreeFunc);
         this._shortcutstree = tree.addChild(this._shortcutstreeFunc);
      }
      
      private function _masterIdFunc(input:ICustomDataInput) : void
      {
         this.masterId = input.readDouble();
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element of SlaveSwitchContextMessage.masterId.");
         }
      }
      
      private function _slaveIdFunc(input:ICustomDataInput) : void
      {
         this.slaveId = input.readDouble();
         if(this.slaveId < -9007199254740992 || this.slaveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.slaveId + ") on element of SlaveSwitchContextMessage.slaveId.");
         }
      }
      
      private function _slaveTurnFunc(input:ICustomDataInput) : void
      {
         this.slaveTurn = input.readVarUhShort();
         if(this.slaveTurn < 0)
         {
            throw new Error("Forbidden value (" + this.slaveTurn + ") on element of SlaveSwitchContextMessage.slaveTurn.");
         }
      }
      
      private function _slaveSpellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._slaveSpellstree.addChild(this._slaveSpellsFunc);
         }
      }
      
      private function _slaveSpellsFunc(input:ICustomDataInput) : void
      {
         var _item:SpellItem = new SpellItem();
         _item.deserialize(input);
         this.slaveSpells.push(_item);
      }
      
      private function _slaveStatstreeFunc(input:ICustomDataInput) : void
      {
         this.slaveStats = new CharacterCharacteristicsInformations();
         this.slaveStats.deserializeAsync(this._slaveStatstree);
      }
      
      private function _shortcutstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._shortcutstree.addChild(this._shortcutsFunc);
         }
      }
      
      private function _shortcutsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:Shortcut = ProtocolTypeManager.getInstance(Shortcut,_id);
         _item.deserialize(input);
         this.shortcuts.push(_item);
      }
   }
}
