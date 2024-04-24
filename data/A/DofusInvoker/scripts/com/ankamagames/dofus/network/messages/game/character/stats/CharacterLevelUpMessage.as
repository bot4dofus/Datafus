package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterLevelUpMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4096;
       
      
      private var _isInitialized:Boolean = false;
      
      public var newLevel:uint = 0;
      
      public function CharacterLevelUpMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4096;
      }
      
      public function initCharacterLevelUpMessage(newLevel:uint = 0) : CharacterLevelUpMessage
      {
         this.newLevel = newLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newLevel = 0;
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
         this.serializeAs_CharacterLevelUpMessage(output);
      }
      
      public function serializeAs_CharacterLevelUpMessage(output:ICustomDataOutput) : void
      {
         if(this.newLevel < 0)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
         }
         output.writeVarShort(this.newLevel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterLevelUpMessage(input);
      }
      
      public function deserializeAs_CharacterLevelUpMessage(input:ICustomDataInput) : void
      {
         this._newLevelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterLevelUpMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterLevelUpMessage(tree:FuncTree) : void
      {
         tree.addChild(this._newLevelFunc);
      }
      
      private function _newLevelFunc(input:ICustomDataInput) : void
      {
         this.newLevel = input.readVarUhShort();
         if(this.newLevel < 0)
         {
            throw new Error("Forbidden value (" + this.newLevel + ") on element of CharacterLevelUpMessage.newLevel.");
         }
      }
   }
}
