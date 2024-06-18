package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayRemoveChallengeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3370;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public function GameRolePlayRemoveChallengeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3370;
      }
      
      public function initGameRolePlayRemoveChallengeMessage(fightId:uint = 0) : GameRolePlayRemoveChallengeMessage
      {
         this.fightId = fightId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
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
         this.serializeAs_GameRolePlayRemoveChallengeMessage(output);
      }
      
      public function serializeAs_GameRolePlayRemoveChallengeMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayRemoveChallengeMessage(input);
      }
      
      public function deserializeAs_GameRolePlayRemoveChallengeMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayRemoveChallengeMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayRemoveChallengeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayRemoveChallengeMessage.fightId.");
         }
      }
   }
}
