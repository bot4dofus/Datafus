package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayAttackMonsterRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9329;
       
      
      private var _isInitialized:Boolean = false;
      
      public var monsterGroupId:Number = 0;
      
      public function GameRolePlayAttackMonsterRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9329;
      }
      
      public function initGameRolePlayAttackMonsterRequestMessage(monsterGroupId:Number = 0) : GameRolePlayAttackMonsterRequestMessage
      {
         this.monsterGroupId = monsterGroupId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.monsterGroupId = 0;
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
         this.serializeAs_GameRolePlayAttackMonsterRequestMessage(output);
      }
      
      public function serializeAs_GameRolePlayAttackMonsterRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.monsterGroupId < -9007199254740992 || this.monsterGroupId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.monsterGroupId + ") on element monsterGroupId.");
         }
         output.writeDouble(this.monsterGroupId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayAttackMonsterRequestMessage(input);
      }
      
      public function deserializeAs_GameRolePlayAttackMonsterRequestMessage(input:ICustomDataInput) : void
      {
         this._monsterGroupIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayAttackMonsterRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayAttackMonsterRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._monsterGroupIdFunc);
      }
      
      private function _monsterGroupIdFunc(input:ICustomDataInput) : void
      {
         this.monsterGroupId = input.readDouble();
         if(this.monsterGroupId < -9007199254740992 || this.monsterGroupId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.monsterGroupId + ") on element of GameRolePlayAttackMonsterRequestMessage.monsterGroupId.");
         }
      }
   }
}
