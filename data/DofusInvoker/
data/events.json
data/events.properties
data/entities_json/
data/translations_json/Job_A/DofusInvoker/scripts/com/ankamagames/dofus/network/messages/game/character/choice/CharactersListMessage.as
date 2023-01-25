package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharactersListMessage extends BasicCharactersListMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1159;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hasStartupActions:Boolean = false;
      
      public function CharactersListMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1159;
      }
      
      public function initCharactersListMessage(characters:Vector.<CharacterBaseInformations> = null, hasStartupActions:Boolean = false) : CharactersListMessage
      {
         super.initBasicCharactersListMessage(characters);
         this.hasStartupActions = hasStartupActions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.hasStartupActions = false;
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
         this.serializeAs_CharactersListMessage(output);
      }
      
      public function serializeAs_CharactersListMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_BasicCharactersListMessage(output);
         output.writeBoolean(this.hasStartupActions);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharactersListMessage(input);
      }
      
      public function deserializeAs_CharactersListMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._hasStartupActionsFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharactersListMessage(tree);
      }
      
      public function deserializeAsyncAs_CharactersListMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._hasStartupActionsFunc);
      }
      
      private function _hasStartupActionsFunc(input:ICustomDataInput) : void
      {
         this.hasStartupActions = input.readBoolean();
      }
   }
}
