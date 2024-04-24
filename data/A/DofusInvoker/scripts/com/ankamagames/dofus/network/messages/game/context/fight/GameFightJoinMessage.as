package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightJoinMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8151;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isTeamPhase:Boolean = false;
      
      public var canBeCancelled:Boolean = false;
      
      public var canSayReady:Boolean = false;
      
      public var isFightStarted:Boolean = false;
      
      public var timeMaxBeforeFightStart:uint = 0;
      
      public var fightType:uint = 0;
      
      public function GameFightJoinMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8151;
      }
      
      public function initGameFightJoinMessage(isTeamPhase:Boolean = false, canBeCancelled:Boolean = false, canSayReady:Boolean = false, isFightStarted:Boolean = false, timeMaxBeforeFightStart:uint = 0, fightType:uint = 0) : GameFightJoinMessage
      {
         this.isTeamPhase = isTeamPhase;
         this.canBeCancelled = canBeCancelled;
         this.canSayReady = canSayReady;
         this.isFightStarted = isFightStarted;
         this.timeMaxBeforeFightStart = timeMaxBeforeFightStart;
         this.fightType = fightType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isTeamPhase = false;
         this.canBeCancelled = false;
         this.canSayReady = false;
         this.isFightStarted = false;
         this.timeMaxBeforeFightStart = 0;
         this.fightType = 0;
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
         this.serializeAs_GameFightJoinMessage(output);
      }
      
      public function serializeAs_GameFightJoinMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isTeamPhase);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.canBeCancelled);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.canSayReady);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isFightStarted);
         output.writeByte(_box0);
         if(this.timeMaxBeforeFightStart < 0)
         {
            throw new Error("Forbidden value (" + this.timeMaxBeforeFightStart + ") on element timeMaxBeforeFightStart.");
         }
         output.writeShort(this.timeMaxBeforeFightStart);
         output.writeByte(this.fightType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightJoinMessage(input);
      }
      
      public function deserializeAs_GameFightJoinMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._timeMaxBeforeFightStartFunc(input);
         this._fightTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightJoinMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightJoinMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._timeMaxBeforeFightStartFunc);
         tree.addChild(this._fightTypeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.isTeamPhase = BooleanByteWrapper.getFlag(_box0,0);
         this.canBeCancelled = BooleanByteWrapper.getFlag(_box0,1);
         this.canSayReady = BooleanByteWrapper.getFlag(_box0,2);
         this.isFightStarted = BooleanByteWrapper.getFlag(_box0,3);
      }
      
      private function _timeMaxBeforeFightStartFunc(input:ICustomDataInput) : void
      {
         this.timeMaxBeforeFightStart = input.readShort();
         if(this.timeMaxBeforeFightStart < 0)
         {
            throw new Error("Forbidden value (" + this.timeMaxBeforeFightStart + ") on element of GameFightJoinMessage.timeMaxBeforeFightStart.");
         }
      }
      
      private function _fightTypeFunc(input:ICustomDataInput) : void
      {
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of GameFightJoinMessage.fightType.");
         }
      }
   }
}
