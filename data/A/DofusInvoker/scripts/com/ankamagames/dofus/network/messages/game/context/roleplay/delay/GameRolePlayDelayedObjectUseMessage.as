package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayDelayedObjectUseMessage extends GameRolePlayDelayedActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3110;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectGID:uint = 0;
      
      public function GameRolePlayDelayedObjectUseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3110;
      }
      
      public function initGameRolePlayDelayedObjectUseMessage(delayedCharacterId:Number = 0, delayTypeId:uint = 0, delayEndTime:Number = 0, objectGID:uint = 0) : GameRolePlayDelayedObjectUseMessage
      {
         super.initGameRolePlayDelayedActionMessage(delayedCharacterId,delayTypeId,delayEndTime);
         this.objectGID = objectGID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.objectGID = 0;
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
         this.serializeAs_GameRolePlayDelayedObjectUseMessage(output);
      }
      
      public function serializeAs_GameRolePlayDelayedObjectUseMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayDelayedActionMessage(output);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayDelayedObjectUseMessage(input);
      }
      
      public function deserializeAs_GameRolePlayDelayedObjectUseMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._objectGIDFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayDelayedObjectUseMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayDelayedObjectUseMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._objectGIDFunc);
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of GameRolePlayDelayedObjectUseMessage.objectGID.");
         }
      }
   }
}
