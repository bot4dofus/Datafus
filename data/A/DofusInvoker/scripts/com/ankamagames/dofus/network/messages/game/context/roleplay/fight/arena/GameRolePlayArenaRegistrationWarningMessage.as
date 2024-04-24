package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaRegistrationWarningMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5553;
       
      
      private var _isInitialized:Boolean = false;
      
      public var battleMode:uint = 3;
      
      public function GameRolePlayArenaRegistrationWarningMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5553;
      }
      
      public function initGameRolePlayArenaRegistrationWarningMessage(battleMode:uint = 3) : GameRolePlayArenaRegistrationWarningMessage
      {
         this.battleMode = battleMode;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.battleMode = 3;
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
         this.serializeAs_GameRolePlayArenaRegistrationWarningMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaRegistrationWarningMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.battleMode);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaRegistrationWarningMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaRegistrationWarningMessage(input:ICustomDataInput) : void
      {
         this._battleModeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaRegistrationWarningMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaRegistrationWarningMessage(tree:FuncTree) : void
      {
         tree.addChild(this._battleModeFunc);
      }
      
      private function _battleModeFunc(input:ICustomDataInput) : void
      {
         this.battleMode = input.readInt();
         if(this.battleMode < 0)
         {
            throw new Error("Forbidden value (" + this.battleMode + ") on element of GameRolePlayArenaRegistrationWarningMessage.battleMode.");
         }
      }
   }
}
