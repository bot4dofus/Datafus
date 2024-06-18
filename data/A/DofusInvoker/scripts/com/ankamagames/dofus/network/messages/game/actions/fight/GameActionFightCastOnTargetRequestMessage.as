package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightCastOnTargetRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6910;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellId:uint = 0;
      
      public var targetId:Number = 0;
      
      public function GameActionFightCastOnTargetRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6910;
      }
      
      public function initGameActionFightCastOnTargetRequestMessage(spellId:uint = 0, targetId:Number = 0) : GameActionFightCastOnTargetRequestMessage
      {
         this.spellId = spellId;
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.targetId = 0;
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
         this.serializeAs_GameActionFightCastOnTargetRequestMessage(output);
      }
      
      public function serializeAs_GameActionFightCastOnTargetRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightCastOnTargetRequestMessage(input);
      }
      
      public function deserializeAs_GameActionFightCastOnTargetRequestMessage(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._targetIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightCastOnTargetRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightCastOnTargetRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._targetIdFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastOnTargetRequestMessage.spellId.");
         }
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightCastOnTargetRequestMessage.targetId.");
         }
      }
   }
}
