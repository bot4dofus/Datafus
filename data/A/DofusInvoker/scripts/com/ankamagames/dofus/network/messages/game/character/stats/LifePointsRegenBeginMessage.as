package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LifePointsRegenBeginMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9965;
       
      
      private var _isInitialized:Boolean = false;
      
      public var regenRate:uint = 0;
      
      public function LifePointsRegenBeginMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9965;
      }
      
      public function initLifePointsRegenBeginMessage(regenRate:uint = 0) : LifePointsRegenBeginMessage
      {
         this.regenRate = regenRate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.regenRate = 0;
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
         this.serializeAs_LifePointsRegenBeginMessage(output);
      }
      
      public function serializeAs_LifePointsRegenBeginMessage(output:ICustomDataOutput) : void
      {
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
         }
         output.writeByte(this.regenRate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LifePointsRegenBeginMessage(input);
      }
      
      public function deserializeAs_LifePointsRegenBeginMessage(input:ICustomDataInput) : void
      {
         this._regenRateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LifePointsRegenBeginMessage(tree);
      }
      
      public function deserializeAsyncAs_LifePointsRegenBeginMessage(tree:FuncTree) : void
      {
         tree.addChild(this._regenRateFunc);
      }
      
      private function _regenRateFunc(input:ICustomDataInput) : void
      {
         this.regenRate = input.readUnsignedByte();
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element of LifePointsRegenBeginMessage.regenRate.");
         }
      }
   }
}
