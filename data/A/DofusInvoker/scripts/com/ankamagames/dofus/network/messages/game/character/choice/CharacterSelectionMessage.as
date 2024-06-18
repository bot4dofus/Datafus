package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterSelectionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6792;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public function CharacterSelectionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6792;
      }
      
      public function initCharacterSelectionMessage(id:Number = 0) : CharacterSelectionMessage
      {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
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
         this.serializeAs_CharacterSelectionMessage(output);
      }
      
      public function serializeAs_CharacterSelectionMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSelectionMessage(input);
      }
      
      public function deserializeAs_CharacterSelectionMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterSelectionMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterSelectionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of CharacterSelectionMessage.id.");
         }
      }
   }
}
