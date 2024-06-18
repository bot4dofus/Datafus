package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SpellVariantActivationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7767;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public var result:Boolean = false;
      
      public function SpellVariantActivationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7767;
      }
      
      public function initSpellVariantActivationMessage(spellId:uint = 0, result:Boolean = false) : SpellVariantActivationMessage
      {
         this.spellId = spellId;
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.result = false;
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
         this.serializeAs_SpellVariantActivationMessage(output);
      }
      
      public function serializeAs_SpellVariantActivationMessage(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         output.writeBoolean(this.result);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpellVariantActivationMessage(input);
      }
      
      public function deserializeAs_SpellVariantActivationMessage(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._resultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpellVariantActivationMessage(tree);
      }
      
      public function deserializeAsyncAs_SpellVariantActivationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._resultFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of SpellVariantActivationMessage.spellId.");
         }
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readBoolean();
      }
   }
}
