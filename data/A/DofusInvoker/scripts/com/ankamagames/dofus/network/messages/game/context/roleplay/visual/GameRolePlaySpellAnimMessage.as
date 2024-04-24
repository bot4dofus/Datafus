package com.ankamagames.dofus.network.messages.game.context.roleplay.visual
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlaySpellAnimMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9686;
       
      
      private var _isInitialized:Boolean = false;
      
      public var casterId:Number = 0;
      
      public var targetCellId:uint = 0;
      
      public var spellId:uint = 0;
      
      public var spellLevel:int = 0;
      
      public var direction:int = 0;
      
      public function GameRolePlaySpellAnimMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9686;
      }
      
      public function initGameRolePlaySpellAnimMessage(casterId:Number = 0, targetCellId:uint = 0, spellId:uint = 0, spellLevel:int = 0, direction:int = 0) : GameRolePlaySpellAnimMessage
      {
         this.casterId = casterId;
         this.targetCellId = targetCellId;
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         this.direction = direction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.casterId = 0;
         this.targetCellId = 0;
         this.spellId = 0;
         this.spellLevel = 0;
         this.direction = 0;
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
         this.serializeAs_GameRolePlaySpellAnimMessage(output);
      }
      
      public function serializeAs_GameRolePlaySpellAnimMessage(output:ICustomDataOutput) : void
      {
         if(this.casterId < 0 || this.casterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.casterId + ") on element casterId.");
         }
         output.writeVarLong(this.casterId);
         if(this.targetCellId < 0 || this.targetCellId > 559)
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
         }
         output.writeVarShort(this.targetCellId);
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
         if(this.direction < -1 || this.direction > 8)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element direction.");
         }
         output.writeShort(this.direction);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlaySpellAnimMessage(input);
      }
      
      public function deserializeAs_GameRolePlaySpellAnimMessage(input:ICustomDataInput) : void
      {
         this._casterIdFunc(input);
         this._targetCellIdFunc(input);
         this._spellIdFunc(input);
         this._spellLevelFunc(input);
         this._directionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlaySpellAnimMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlaySpellAnimMessage(tree:FuncTree) : void
      {
         tree.addChild(this._casterIdFunc);
         tree.addChild(this._targetCellIdFunc);
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._spellLevelFunc);
         tree.addChild(this._directionFunc);
      }
      
      private function _casterIdFunc(input:ICustomDataInput) : void
      {
         this.casterId = input.readVarUhLong();
         if(this.casterId < 0 || this.casterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.casterId + ") on element of GameRolePlaySpellAnimMessage.casterId.");
         }
      }
      
      private function _targetCellIdFunc(input:ICustomDataInput) : void
      {
         this.targetCellId = input.readVarUhShort();
         if(this.targetCellId < 0 || this.targetCellId > 559)
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameRolePlaySpellAnimMessage.targetCellId.");
         }
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameRolePlaySpellAnimMessage.spellId.");
         }
      }
      
      private function _spellLevelFunc(input:ICustomDataInput) : void
      {
         this.spellLevel = input.readShort();
         if(this.spellLevel < 1 || this.spellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameRolePlaySpellAnimMessage.spellLevel.");
         }
      }
      
      private function _directionFunc(input:ICustomDataInput) : void
      {
         this.direction = input.readShort();
         if(this.direction < -1 || this.direction > 8)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of GameRolePlaySpellAnimMessage.direction.");
         }
      }
   }
}
