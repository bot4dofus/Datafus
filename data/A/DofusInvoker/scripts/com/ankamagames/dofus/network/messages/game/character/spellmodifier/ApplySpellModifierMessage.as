package com.ankamagames.dofus.network.messages.game.character.spellmodifier
{
   import com.ankamagames.dofus.network.types.game.character.spellmodifier.SpellModifierMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ApplySpellModifierMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1373;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actorId:Number = 0;
      
      public var modifier:SpellModifierMessage;
      
      private var _modifiertree:FuncTree;
      
      public function ApplySpellModifierMessage()
      {
         this.modifier = new SpellModifierMessage();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1373;
      }
      
      public function initApplySpellModifierMessage(actorId:Number = 0, modifier:SpellModifierMessage = null) : ApplySpellModifierMessage
      {
         this.actorId = actorId;
         this.modifier = modifier;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actorId = 0;
         this.modifier = new SpellModifierMessage();
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
         this.serializeAs_ApplySpellModifierMessage(output);
      }
      
      public function serializeAs_ApplySpellModifierMessage(output:ICustomDataOutput) : void
      {
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element actorId.");
         }
         output.writeDouble(this.actorId);
         this.modifier.serializeAs_SpellModifierMessage(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ApplySpellModifierMessage(input);
      }
      
      public function deserializeAs_ApplySpellModifierMessage(input:ICustomDataInput) : void
      {
         this._actorIdFunc(input);
         this.modifier = new SpellModifierMessage();
         this.modifier.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ApplySpellModifierMessage(tree);
      }
      
      public function deserializeAsyncAs_ApplySpellModifierMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actorIdFunc);
         this._modifiertree = tree.addChild(this._modifiertreeFunc);
      }
      
      private function _actorIdFunc(input:ICustomDataInput) : void
      {
         this.actorId = input.readDouble();
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element of ApplySpellModifierMessage.actorId.");
         }
      }
      
      private function _modifiertreeFunc(input:ICustomDataInput) : void
      {
         this.modifier = new SpellModifierMessage();
         this.modifier.deserializeAsync(this._modifiertree);
      }
   }
}
