package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightTriggerGlyphTrapMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3525;
       
      
      private var _isInitialized:Boolean = false;
      
      public var markId:int = 0;
      
      public var markImpactCell:uint = 0;
      
      public var triggeringCharacterId:Number = 0;
      
      public var triggeredSpellId:uint = 0;
      
      public function GameActionFightTriggerGlyphTrapMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3525;
      }
      
      public function initGameActionFightTriggerGlyphTrapMessage(actionId:uint = 0, sourceId:Number = 0, markId:int = 0, markImpactCell:uint = 0, triggeringCharacterId:Number = 0, triggeredSpellId:uint = 0) : GameActionFightTriggerGlyphTrapMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.markId = markId;
         this.markImpactCell = markImpactCell;
         this.triggeringCharacterId = triggeringCharacterId;
         this.triggeredSpellId = triggeredSpellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.markId = 0;
         this.markImpactCell = 0;
         this.triggeringCharacterId = 0;
         this.triggeredSpellId = 0;
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
         this.serializeAs_GameActionFightTriggerGlyphTrapMessage(output);
      }
      
      public function serializeAs_GameActionFightTriggerGlyphTrapMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.markId);
         if(this.markImpactCell < 0)
         {
            throw new Error("Forbidden value (" + this.markImpactCell + ") on element markImpactCell.");
         }
         output.writeVarShort(this.markImpactCell);
         if(this.triggeringCharacterId < -9007199254740992 || this.triggeringCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.triggeringCharacterId + ") on element triggeringCharacterId.");
         }
         output.writeDouble(this.triggeringCharacterId);
         if(this.triggeredSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.triggeredSpellId + ") on element triggeredSpellId.");
         }
         output.writeVarShort(this.triggeredSpellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightTriggerGlyphTrapMessage(input);
      }
      
      public function deserializeAs_GameActionFightTriggerGlyphTrapMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._markIdFunc(input);
         this._markImpactCellFunc(input);
         this._triggeringCharacterIdFunc(input);
         this._triggeredSpellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightTriggerGlyphTrapMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightTriggerGlyphTrapMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._markIdFunc);
         tree.addChild(this._markImpactCellFunc);
         tree.addChild(this._triggeringCharacterIdFunc);
         tree.addChild(this._triggeredSpellIdFunc);
      }
      
      private function _markIdFunc(input:ICustomDataInput) : void
      {
         this.markId = input.readShort();
      }
      
      private function _markImpactCellFunc(input:ICustomDataInput) : void
      {
         this.markImpactCell = input.readVarUhShort();
         if(this.markImpactCell < 0)
         {
            throw new Error("Forbidden value (" + this.markImpactCell + ") on element of GameActionFightTriggerGlyphTrapMessage.markImpactCell.");
         }
      }
      
      private function _triggeringCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.triggeringCharacterId = input.readDouble();
         if(this.triggeringCharacterId < -9007199254740992 || this.triggeringCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.triggeringCharacterId + ") on element of GameActionFightTriggerGlyphTrapMessage.triggeringCharacterId.");
         }
      }
      
      private function _triggeredSpellIdFunc(input:ICustomDataInput) : void
      {
         this.triggeredSpellId = input.readVarUhShort();
         if(this.triggeredSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.triggeredSpellId + ") on element of GameActionFightTriggerGlyphTrapMessage.triggeredSpellId.");
         }
      }
   }
}
