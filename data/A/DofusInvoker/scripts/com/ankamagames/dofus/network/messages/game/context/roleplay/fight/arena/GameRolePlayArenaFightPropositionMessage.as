package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaFightPropositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5667;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightId:uint = 0;
      
      public var alliesId:Vector.<Number>;
      
      public var duration:uint = 0;
      
      private var _alliesIdtree:FuncTree;
      
      public function GameRolePlayArenaFightPropositionMessage()
      {
         this.alliesId = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5667;
      }
      
      public function initGameRolePlayArenaFightPropositionMessage(fightId:uint = 0, alliesId:Vector.<Number> = null, duration:uint = 0) : GameRolePlayArenaFightPropositionMessage
      {
         this.fightId = fightId;
         this.alliesId = alliesId;
         this.duration = duration;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fightId = 0;
         this.alliesId = new Vector.<Number>();
         this.duration = 0;
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
         this.serializeAs_GameRolePlayArenaFightPropositionMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaFightPropositionMessage(output:ICustomDataOutput) : void
      {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeShort(this.alliesId.length);
         for(var _i2:uint = 0; _i2 < this.alliesId.length; _i2++)
         {
            if(this.alliesId[_i2] < -9007199254740992 || this.alliesId[_i2] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.alliesId[_i2] + ") on element 2 (starting at 1) of alliesId.");
            }
            output.writeDouble(this.alliesId[_i2]);
         }
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element duration.");
         }
         output.writeVarShort(this.duration);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaFightPropositionMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaFightPropositionMessage(input:ICustomDataInput) : void
      {
         var _val2:Number = NaN;
         this._fightIdFunc(input);
         var _alliesIdLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _alliesIdLen; _i2++)
         {
            _val2 = input.readDouble();
            if(_val2 < -9007199254740992 || _val2 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of alliesId.");
            }
            this.alliesId.push(_val2);
         }
         this._durationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaFightPropositionMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaFightPropositionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._fightIdFunc);
         this._alliesIdtree = tree.addChild(this._alliesIdtreeFunc);
         tree.addChild(this._durationFunc);
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayArenaFightPropositionMessage.fightId.");
         }
      }
      
      private function _alliesIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._alliesIdtree.addChild(this._alliesIdFunc);
         }
      }
      
      private function _alliesIdFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readDouble();
         if(_val < -9007199254740992 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of alliesId.");
         }
         this.alliesId.push(_val);
      }
      
      private function _durationFunc(input:ICustomDataInput) : void
      {
         this.duration = input.readVarUhShort();
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element of GameRolePlayArenaFightPropositionMessage.duration.");
         }
      }
   }
}
