package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterSelectedForceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4050;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:int = 0;
      
      public function CharacterSelectedForceMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4050;
      }
      
      public function initCharacterSelectedForceMessage(id:int = 0) : CharacterSelectedForceMessage
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
         this.serializeAs_CharacterSelectedForceMessage(output);
      }
      
      public function serializeAs_CharacterSelectedForceMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 1 || this.id > 2147483647)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeInt(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSelectedForceMessage(input);
      }
      
      public function deserializeAs_CharacterSelectedForceMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterSelectedForceMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterSelectedForceMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readInt();
         if(this.id < 1 || this.id > 2147483647)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of CharacterSelectedForceMessage.id.");
         }
      }
   }
}
