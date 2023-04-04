package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateSpellModifierMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3115;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actorId:Number = 0;
      
      public var spellModifier:CharacterSpellModification;
      
      private var _spellModifiertree:FuncTree;
      
      public function UpdateSpellModifierMessage()
      {
         this.spellModifier = new CharacterSpellModification();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3115;
      }
      
      public function initUpdateSpellModifierMessage(actorId:Number = 0, spellModifier:CharacterSpellModification = null) : UpdateSpellModifierMessage
      {
         this.actorId = actorId;
         this.spellModifier = spellModifier;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actorId = 0;
         this.spellModifier = new CharacterSpellModification();
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
         this.serializeAs_UpdateSpellModifierMessage(output);
      }
      
      public function serializeAs_UpdateSpellModifierMessage(output:ICustomDataOutput) : void
      {
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element actorId.");
         }
         output.writeDouble(this.actorId);
         this.spellModifier.serializeAs_CharacterSpellModification(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateSpellModifierMessage(input);
      }
      
      public function deserializeAs_UpdateSpellModifierMessage(input:ICustomDataInput) : void
      {
         this._actorIdFunc(input);
         this.spellModifier = new CharacterSpellModification();
         this.spellModifier.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateSpellModifierMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateSpellModifierMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actorIdFunc);
         this._spellModifiertree = tree.addChild(this._spellModifiertreeFunc);
      }
      
      private function _actorIdFunc(input:ICustomDataInput) : void
      {
         this.actorId = input.readDouble();
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element of UpdateSpellModifierMessage.actorId.");
         }
      }
      
      private function _spellModifiertreeFunc(input:ICustomDataInput) : void
      {
         this.spellModifier = new CharacterSpellModification();
         this.spellModifier.deserializeAsync(this._spellModifiertree);
      }
   }
}
