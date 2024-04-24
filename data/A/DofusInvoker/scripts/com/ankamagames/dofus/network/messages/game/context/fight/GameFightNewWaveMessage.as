package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightNewWaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2673;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:uint = 0;
      
      public var teamId:uint = 2;
      
      public var nbTurnBeforeNextWave:int = 0;
      
      public function GameFightNewWaveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2673;
      }
      
      public function initGameFightNewWaveMessage(id:uint = 0, teamId:uint = 2, nbTurnBeforeNextWave:int = 0) : GameFightNewWaveMessage
      {
         this.id = id;
         this.teamId = teamId;
         this.nbTurnBeforeNextWave = nbTurnBeforeNextWave;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.teamId = 2;
         this.nbTurnBeforeNextWave = 0;
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
         this.serializeAs_GameFightNewWaveMessage(output);
      }
      
      public function serializeAs_GameFightNewWaveMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeByte(this.id);
         output.writeByte(this.teamId);
         output.writeShort(this.nbTurnBeforeNextWave);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightNewWaveMessage(input);
      }
      
      public function deserializeAs_GameFightNewWaveMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._teamIdFunc(input);
         this._nbTurnBeforeNextWaveFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightNewWaveMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightNewWaveMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._teamIdFunc);
         tree.addChild(this._nbTurnBeforeNextWaveFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readByte();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameFightNewWaveMessage.id.");
         }
      }
      
      private function _teamIdFunc(input:ICustomDataInput) : void
      {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightNewWaveMessage.teamId.");
         }
      }
      
      private function _nbTurnBeforeNextWaveFunc(input:ICustomDataInput) : void
      {
         this.nbTurnBeforeNextWave = input.readShort();
      }
   }
}
