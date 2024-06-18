package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightSpellCastMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2679;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public var spellLevel:int = 0;
      
      public var portalsIds:Vector.<int>;
      
      private var _portalsIdstree:FuncTree;
      
      public function GameActionFightSpellCastMessage()
      {
         this.portalsIds = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2679;
      }
      
      public function initGameActionFightSpellCastMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, destinationCellId:int = 0, critical:uint = 1, silentCast:Boolean = false, verboseCast:Boolean = false, spellId:uint = 0, spellLevel:int = 0, portalsIds:Vector.<int> = null) : GameActionFightSpellCastMessage
      {
         super.initAbstractGameActionFightTargetedAbilityMessage(actionId,sourceId,targetId,destinationCellId,critical,silentCast,verboseCast);
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         this.portalsIds = portalsIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spellId = 0;
         this.spellLevel = 0;
         this.portalsIds = new Vector.<int>();
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
         this.serializeAs_GameActionFightSpellCastMessage(output);
      }
      
      public function serializeAs_GameActionFightSpellCastMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         if(this.spellLevel < 1 || this.spellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
         }
         output.writeShort(this.spellLevel);
         output.writeShort(this.portalsIds.length);
         for(var _i3:uint = 0; _i3 < this.portalsIds.length; _i3++)
         {
            output.writeShort(this.portalsIds[_i3]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightSpellCastMessage(input);
      }
      
      public function deserializeAs_GameActionFightSpellCastMessage(input:ICustomDataInput) : void
      {
         var _val3:int = 0;
         super.deserialize(input);
         this._spellIdFunc(input);
         this._spellLevelFunc(input);
         var _portalsIdsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _portalsIdsLen; _i3++)
         {
            _val3 = input.readShort();
            this.portalsIds.push(_val3);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightSpellCastMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightSpellCastMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._spellLevelFunc);
         this._portalsIdstree = tree.addChild(this._portalsIdstreeFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightSpellCastMessage.spellId.");
         }
      }
      
      private function _spellLevelFunc(input:ICustomDataInput) : void
      {
         this.spellLevel = input.readShort();
         if(this.spellLevel < 1 || this.spellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameActionFightSpellCastMessage.spellLevel.");
         }
      }
      
      private function _portalsIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._portalsIdstree.addChild(this._portalsIdsFunc);
         }
      }
      
      private function _portalsIdsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readShort();
         this.portalsIds.push(_val);
      }
   }
}
