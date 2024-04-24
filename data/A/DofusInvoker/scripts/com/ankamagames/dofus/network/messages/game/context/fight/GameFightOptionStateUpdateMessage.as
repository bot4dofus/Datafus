package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightOptionStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 805;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var teamId:uint = 2;
      
      public var option:uint = 3;
      
      public var state:Boolean = false;
      
      public function GameFightOptionStateUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 805;
      }
      
      public function initGameFightOptionStateUpdateMessage(fightId:uint = 0, teamId:uint = 2, option:uint = 3, state:Boolean = false) : GameFightOptionStateUpdateMessage
      {
         this.fightId = fightId;
         this.teamId = teamId;
         this.option = option;
         this.state = state;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.teamId = 2;
         this.option = 3;
         this.state = false;
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
         this.serializeAs_GameFightOptionStateUpdateMessage(output);
      }
      
      public function serializeAs_GameFightOptionStateUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeByte(this.teamId);
         output.writeByte(this.option);
         output.writeBoolean(this.state);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightOptionStateUpdateMessage(input);
      }
      
      public function deserializeAs_GameFightOptionStateUpdateMessage(input:ICustomDataInput) : void
      {
         this._fightIdFunc(input);
         this._teamIdFunc(input);
         this._optionFunc(input);
         this._stateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightOptionStateUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightOptionStateUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._teamIdFunc);
         tree.addChild(this._optionFunc);
         tree.addChild(this._stateFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightOptionStateUpdateMessage.fightId.");
         }
      }
      
      private function _teamIdFunc(input:ICustomDataInput) : void
      {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightOptionStateUpdateMessage.teamId.");
         }
      }
      
      private function _optionFunc(input:ICustomDataInput) : void
      {
         this.option = input.readByte();
         if(this.option < 0)
         {
            throw new Error("Forbidden value (" + this.option + ") on element of GameFightOptionStateUpdateMessage.option.");
         }
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readBoolean();
      }
   }
}
