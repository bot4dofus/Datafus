package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaRegistrationStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4586;
       
      
      private var _isInitialized:Boolean = false;
      
      public var registered:Boolean = false;
      
      public var step:uint = 0;
      
      public var battleMode:uint = 3;
      
      public function GameRolePlayArenaRegistrationStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4586;
      }
      
      public function initGameRolePlayArenaRegistrationStatusMessage(registered:Boolean = false, step:uint = 0, battleMode:uint = 3) : GameRolePlayArenaRegistrationStatusMessage
      {
         this.registered = registered;
         this.step = step;
         this.battleMode = battleMode;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.registered = false;
         this.step = 0;
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
         this.serializeAs_GameRolePlayArenaRegistrationStatusMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaRegistrationStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.registered);
         output.writeByte(this.step);
         output.writeInt(this.battleMode);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaRegistrationStatusMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaRegistrationStatusMessage(input:ICustomDataInput) : void
      {
         this._registeredFunc(input);
         this._stepFunc(input);
         this._battleModeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaRegistrationStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaRegistrationStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._registeredFunc);
         tree.addChild(this._stepFunc);
         tree.addChild(this._battleModeFunc);
      }
      
      private function _registeredFunc(input:ICustomDataInput) : void
      {
         this.registered = input.readBoolean();
      }
      
      private function _stepFunc(input:ICustomDataInput) : void
      {
         this.step = input.readByte();
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element of GameRolePlayArenaRegistrationStatusMessage.step.");
         }
      }
      
      private function _battleModeFunc(input:ICustomDataInput) : void
      {
         this.battleMode = input.readInt();
         if(this.battleMode < 0)
         {
            throw new Error("Forbidden value (" + this.battleMode + ") on element of GameRolePlayArenaRegistrationStatusMessage.battleMode.");
         }
      }
   }
}
