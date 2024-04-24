package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInformationsGeneralMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1991;
       
      
      private var _isInitialized:Boolean = false;
      
      public var abandonnedPaddock:Boolean = false;
      
      public var level:uint = 0;
      
      public var expLevelFloor:Number = 0;
      
      public var experience:Number = 0;
      
      public var expNextLevelFloor:Number = 0;
      
      public var creationDate:uint = 0;
      
      public var score:int = 0;
      
      public function GuildInformationsGeneralMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1991;
      }
      
      public function initGuildInformationsGeneralMessage(abandonnedPaddock:Boolean = false, level:uint = 0, expLevelFloor:Number = 0, experience:Number = 0, expNextLevelFloor:Number = 0, creationDate:uint = 0, score:int = 0) : GuildInformationsGeneralMessage
      {
         this.abandonnedPaddock = abandonnedPaddock;
         this.level = level;
         this.expLevelFloor = expLevelFloor;
         this.experience = experience;
         this.expNextLevelFloor = expNextLevelFloor;
         this.creationDate = creationDate;
         this.score = score;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.abandonnedPaddock = false;
         this.level = 0;
         this.expLevelFloor = 0;
         this.experience = 0;
         this.expNextLevelFloor = 0;
         this.creationDate = 0;
         this.score = 0;
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
         this.serializeAs_GuildInformationsGeneralMessage(output);
      }
      
      public function serializeAs_GuildInformationsGeneralMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.abandonnedPaddock);
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeByte(this.level);
         if(this.expLevelFloor < 0 || this.expLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expLevelFloor + ") on element expLevelFloor.");
         }
         output.writeVarLong(this.expLevelFloor);
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         output.writeVarLong(this.experience);
         if(this.expNextLevelFloor < 0 || this.expNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element expNextLevelFloor.");
         }
         output.writeVarLong(this.expNextLevelFloor);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         output.writeInt(this.creationDate);
         output.writeInt(this.score);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInformationsGeneralMessage(input);
      }
      
      public function deserializeAs_GuildInformationsGeneralMessage(input:ICustomDataInput) : void
      {
         this._abandonnedPaddockFunc(input);
         this._levelFunc(input);
         this._expLevelFloorFunc(input);
         this._experienceFunc(input);
         this._expNextLevelFloorFunc(input);
         this._creationDateFunc(input);
         this._scoreFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInformationsGeneralMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInformationsGeneralMessage(tree:FuncTree) : void
      {
         tree.addChild(this._abandonnedPaddockFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._expLevelFloorFunc);
         tree.addChild(this._experienceFunc);
         tree.addChild(this._expNextLevelFloorFunc);
         tree.addChild(this._creationDateFunc);
         tree.addChild(this._scoreFunc);
      }
      
      private function _abandonnedPaddockFunc(input:ICustomDataInput) : void
      {
         this.abandonnedPaddock = input.readBoolean();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readUnsignedByte();
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GuildInformationsGeneralMessage.level.");
         }
      }
      
      private function _expLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.expLevelFloor = input.readVarUhLong();
         if(this.expLevelFloor < 0 || this.expLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expLevelFloor + ") on element of GuildInformationsGeneralMessage.expLevelFloor.");
         }
      }
      
      private function _experienceFunc(input:ICustomDataInput) : void
      {
         this.experience = input.readVarUhLong();
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of GuildInformationsGeneralMessage.experience.");
         }
      }
      
      private function _expNextLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.expNextLevelFloor = input.readVarUhLong();
         if(this.expNextLevelFloor < 0 || this.expNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element of GuildInformationsGeneralMessage.expNextLevelFloor.");
         }
      }
      
      private function _creationDateFunc(input:ICustomDataInput) : void
      {
         this.creationDate = input.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildInformationsGeneralMessage.creationDate.");
         }
      }
      
      private function _scoreFunc(input:ICustomDataInput) : void
      {
         this.score = input.readInt();
      }
   }
}
