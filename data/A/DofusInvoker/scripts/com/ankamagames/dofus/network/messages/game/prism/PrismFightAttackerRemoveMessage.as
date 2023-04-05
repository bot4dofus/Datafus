package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismFightAttackerRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9107;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public var fightId:uint = 0;
      
      public var fighterToRemoveId:Number = 0;
      
      public function PrismFightAttackerRemoveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9107;
      }
      
      public function initPrismFightAttackerRemoveMessage(subAreaId:uint = 0, fightId:uint = 0, fighterToRemoveId:Number = 0) : PrismFightAttackerRemoveMessage
      {
         this.subAreaId = subAreaId;
         this.fightId = fightId;
         this.fighterToRemoveId = fighterToRemoveId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.fightId = 0;
         this.fighterToRemoveId = 0;
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
         this.serializeAs_PrismFightAttackerRemoveMessage(output);
      }
      
      public function serializeAs_PrismFightAttackerRemoveMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         if(this.fighterToRemoveId < 0 || this.fighterToRemoveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element fighterToRemoveId.");
         }
         output.writeVarLong(this.fighterToRemoveId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightAttackerRemoveMessage(input);
      }
      
      public function deserializeAs_PrismFightAttackerRemoveMessage(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._fightIdFunc(input);
         this._fighterToRemoveIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismFightAttackerRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismFightAttackerRemoveMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._fighterToRemoveIdFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightAttackerRemoveMessage.subAreaId.");
         }
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of PrismFightAttackerRemoveMessage.fightId.");
         }
      }
      
      private function _fighterToRemoveIdFunc(input:ICustomDataInput) : void
      {
         this.fighterToRemoveId = input.readVarUhLong();
         if(this.fighterToRemoveId < 0 || this.fighterToRemoveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element of PrismFightAttackerRemoveMessage.fighterToRemoveId.");
         }
      }
   }
}
