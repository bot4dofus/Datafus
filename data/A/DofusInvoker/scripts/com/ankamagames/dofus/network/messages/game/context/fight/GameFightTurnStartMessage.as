package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightTurnStartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1384;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public var waitTime:uint = 0;
      
      public function GameFightTurnStartMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1384;
      }
      
      public function initGameFightTurnStartMessage(id:Number = 0, waitTime:uint = 0) : GameFightTurnStartMessage
      {
         this.id = id;
         this.waitTime = waitTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.waitTime = 0;
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
         this.serializeAs_GameFightTurnStartMessage(output);
      }
      
      public function serializeAs_GameFightTurnStartMessage(output:ICustomDataOutput) : void
      {
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         if(this.waitTime < 0)
         {
            throw new Error("Forbidden value (" + this.waitTime + ") on element waitTime.");
         }
         output.writeVarInt(this.waitTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTurnStartMessage(input);
      }
      
      public function deserializeAs_GameFightTurnStartMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._waitTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightTurnStartMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightTurnStartMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._waitTimeFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameFightTurnStartMessage.id.");
         }
      }
      
      private function _waitTimeFunc(input:ICustomDataInput) : void
      {
         this.waitTime = input.readVarUhInt();
         if(this.waitTime < 0)
         {
            throw new Error("Forbidden value (" + this.waitTime + ") on element of GameFightTurnStartMessage.waitTime.");
         }
      }
   }
}
