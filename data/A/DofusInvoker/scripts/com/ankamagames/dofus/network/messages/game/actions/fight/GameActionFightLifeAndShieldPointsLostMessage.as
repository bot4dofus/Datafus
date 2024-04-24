package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightLifeAndShieldPointsLostMessage extends GameActionFightLifePointsLostMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8896;
       
      
      private var _isInitialized:Boolean = false;
      
      public var shieldLoss:uint = 0;
      
      public function GameActionFightLifeAndShieldPointsLostMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8896;
      }
      
      public function initGameActionFightLifeAndShieldPointsLostMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, loss:uint = 0, permanentDamages:uint = 0, elementId:int = 0, shieldLoss:uint = 0) : GameActionFightLifeAndShieldPointsLostMessage
      {
         super.initGameActionFightLifePointsLostMessage(actionId,sourceId,targetId,loss,permanentDamages,elementId);
         this.shieldLoss = shieldLoss;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.shieldLoss = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionFightLifeAndShieldPointsLostMessage(output);
      }
      
      public function serializeAs_GameActionFightLifeAndShieldPointsLostMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameActionFightLifePointsLostMessage(output);
         if(this.shieldLoss < 0)
         {
            throw new Error("Forbidden value (" + this.shieldLoss + ") on element shieldLoss.");
         }
         output.writeVarShort(this.shieldLoss);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightLifeAndShieldPointsLostMessage(input);
      }
      
      public function deserializeAs_GameActionFightLifeAndShieldPointsLostMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._shieldLossFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightLifeAndShieldPointsLostMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightLifeAndShieldPointsLostMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._shieldLossFunc);
      }
      
      private function _shieldLossFunc(input:ICustomDataInput) : void
      {
         this.shieldLoss = input.readVarUhShort();
         if(this.shieldLoss < 0)
         {
            throw new Error("Forbidden value (" + this.shieldLoss + ") on element of GameActionFightLifeAndShieldPointsLostMessage.shieldLoss.");
         }
      }
   }
}
