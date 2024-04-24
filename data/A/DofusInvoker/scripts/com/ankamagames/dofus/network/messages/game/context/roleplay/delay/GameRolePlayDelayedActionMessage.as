package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayDelayedActionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1933;
       
      
      private var _isInitialized:Boolean = false;
      
      public var delayedCharacterId:Number = 0;
      
      public var delayTypeId:uint = 0;
      
      public var delayEndTime:Number = 0;
      
      public function GameRolePlayDelayedActionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1933;
      }
      
      public function initGameRolePlayDelayedActionMessage(delayedCharacterId:Number = 0, delayTypeId:uint = 0, delayEndTime:Number = 0) : GameRolePlayDelayedActionMessage
      {
         this.delayedCharacterId = delayedCharacterId;
         this.delayTypeId = delayTypeId;
         this.delayEndTime = delayEndTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.delayedCharacterId = 0;
         this.delayTypeId = 0;
         this.delayEndTime = 0;
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
         this.serializeAs_GameRolePlayDelayedActionMessage(output);
      }
      
      public function serializeAs_GameRolePlayDelayedActionMessage(output:ICustomDataOutput) : void
      {
         if(this.delayedCharacterId < -9007199254740992 || this.delayedCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.delayedCharacterId + ") on element delayedCharacterId.");
         }
         output.writeDouble(this.delayedCharacterId);
         output.writeByte(this.delayTypeId);
         if(this.delayEndTime < 0 || this.delayEndTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element delayEndTime.");
         }
         output.writeDouble(this.delayEndTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayDelayedActionMessage(input);
      }
      
      public function deserializeAs_GameRolePlayDelayedActionMessage(input:ICustomDataInput) : void
      {
         this._delayedCharacterIdFunc(input);
         this._delayTypeIdFunc(input);
         this._delayEndTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayDelayedActionMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayDelayedActionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._delayedCharacterIdFunc);
         tree.addChild(this._delayTypeIdFunc);
         tree.addChild(this._delayEndTimeFunc);
      }
      
      private function _delayedCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.delayedCharacterId = input.readDouble();
         if(this.delayedCharacterId < -9007199254740992 || this.delayedCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.delayedCharacterId + ") on element of GameRolePlayDelayedActionMessage.delayedCharacterId.");
         }
      }
      
      private function _delayTypeIdFunc(input:ICustomDataInput) : void
      {
         this.delayTypeId = input.readByte();
         if(this.delayTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.delayTypeId + ") on element of GameRolePlayDelayedActionMessage.delayTypeId.");
         }
      }
      
      private function _delayEndTimeFunc(input:ICustomDataInput) : void
      {
         this.delayEndTime = input.readDouble();
         if(this.delayEndTime < 0 || this.delayEndTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element of GameRolePlayDelayedActionMessage.delayEndTime.");
         }
      }
   }
}
