package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterFirstSelectionMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7333;
       
      
      private var _isInitialized:Boolean = false;
      
      public var doTutorial:Boolean = false;
      
      public function CharacterFirstSelectionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7333;
      }
      
      public function initCharacterFirstSelectionMessage(id:Number = 0, doTutorial:Boolean = false) : CharacterFirstSelectionMessage
      {
         super.initCharacterSelectionMessage(id);
         this.doTutorial = doTutorial;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.doTutorial = false;
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
         this.serializeAs_CharacterFirstSelectionMessage(output);
      }
      
      public function serializeAs_CharacterFirstSelectionMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterSelectionMessage(output);
         output.writeBoolean(this.doTutorial);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterFirstSelectionMessage(input);
      }
      
      public function deserializeAs_CharacterFirstSelectionMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._doTutorialFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterFirstSelectionMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterFirstSelectionMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._doTutorialFunc);
      }
      
      private function _doTutorialFunc(input:ICustomDataInput) : void
      {
         this.doTutorial = input.readBoolean();
      }
   }
}
