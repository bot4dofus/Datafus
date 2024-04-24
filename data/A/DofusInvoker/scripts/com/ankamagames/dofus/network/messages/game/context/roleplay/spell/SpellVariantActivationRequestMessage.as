package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SpellVariantActivationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5428;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public function SpellVariantActivationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5428;
      }
      
      public function initSpellVariantActivationRequestMessage(spellId:uint = 0) : SpellVariantActivationRequestMessage
      {
         this.spellId = spellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpellVariantActivationRequestMessage(output);
      }
      
      public function serializeAs_SpellVariantActivationRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpellVariantActivationRequestMessage(input);
      }
      
      public function deserializeAs_SpellVariantActivationRequestMessage(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpellVariantActivationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_SpellVariantActivationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of SpellVariantActivationRequestMessage.spellId.");
         }
      }
   }
}
