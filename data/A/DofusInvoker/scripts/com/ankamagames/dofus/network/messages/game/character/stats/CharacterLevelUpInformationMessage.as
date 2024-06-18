package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterLevelUpInformationMessage extends CharacterLevelUpMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3031;
       
      
      private var _isInitialized:Boolean = false;
      
      public var name:String = "";
      
      public var id:Number = 0;
      
      public function CharacterLevelUpInformationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3031;
      }
      
      public function initCharacterLevelUpInformationMessage(newLevel:uint = 0, name:String = "", id:Number = 0) : CharacterLevelUpInformationMessage
      {
         super.initCharacterLevelUpMessage(newLevel);
         this.name = name;
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterLevelUpInformationMessage(output);
      }
      
      public function serializeAs_CharacterLevelUpInformationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterLevelUpMessage(output);
         output.writeUTF(this.name);
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterLevelUpInformationMessage(input);
      }
      
      public function deserializeAs_CharacterLevelUpInformationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
         this._idFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterLevelUpInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterLevelUpInformationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         tree.addChild(this._idFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of CharacterLevelUpInformationMessage.id.");
         }
      }
   }
}
