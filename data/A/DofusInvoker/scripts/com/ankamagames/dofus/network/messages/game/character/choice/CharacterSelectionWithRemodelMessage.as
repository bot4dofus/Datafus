package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.choice.RemodelingInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterSelectionWithRemodelMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 512;
       
      
      private var _isInitialized:Boolean = false;
      
      public var remodel:RemodelingInformation;
      
      private var _remodeltree:FuncTree;
      
      public function CharacterSelectionWithRemodelMessage()
      {
         this.remodel = new RemodelingInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 512;
      }
      
      public function initCharacterSelectionWithRemodelMessage(id:Number = 0, remodel:RemodelingInformation = null) : CharacterSelectionWithRemodelMessage
      {
         super.initCharacterSelectionMessage(id);
         this.remodel = remodel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.remodel = new RemodelingInformation();
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
         this.serializeAs_CharacterSelectionWithRemodelMessage(output);
      }
      
      public function serializeAs_CharacterSelectionWithRemodelMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterSelectionMessage(output);
         this.remodel.serializeAs_RemodelingInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSelectionWithRemodelMessage(input);
      }
      
      public function deserializeAs_CharacterSelectionWithRemodelMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.remodel = new RemodelingInformation();
         this.remodel.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterSelectionWithRemodelMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterSelectionWithRemodelMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._remodeltree = tree.addChild(this._remodeltreeFunc);
      }
      
      private function _remodeltreeFunc(input:ICustomDataInput) : void
      {
         this.remodel = new RemodelingInformation();
         this.remodel.deserializeAsync(this._remodeltree);
      }
   }
}
