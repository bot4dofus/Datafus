package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightJoinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7552;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fighterId:Number = 0;
      
      public var fightId:uint = 0;
      
      public function GameFightJoinRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7552;
      }
      
      public function initGameFightJoinRequestMessage(fighterId:Number = 0, fightId:uint = 0) : GameFightJoinRequestMessage
      {
         this.fighterId = fighterId;
         this.fightId = fightId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fighterId = 0;
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
         this.serializeAs_GameFightJoinRequestMessage(output);
      }
      
      public function serializeAs_GameFightJoinRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.fighterId < -9007199254740992 || this.fighterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fighterId + ") on element fighterId.");
         }
         output.writeDouble(this.fighterId);
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightJoinRequestMessage(input);
      }
      
      public function deserializeAs_GameFightJoinRequestMessage(input:ICustomDataInput) : void
      {
         this._fighterIdFunc(input);
         this._fightIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightJoinRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightJoinRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fighterIdFunc);
         tree.addChild(this._fightIdFunc);
      }
      
      private function _fighterIdFunc(input:ICustomDataInput) : void
      {
         this.fighterId = input.readDouble();
         if(this.fighterId < -9007199254740992 || this.fighterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fighterId + ") on element of GameFightJoinRequestMessage.fighterId.");
         }
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightJoinRequestMessage.fightId.");
         }
      }
   }
}
