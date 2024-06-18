package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightCloseCombatMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2405;
       
      
      private var _isInitialized:Boolean = false;
      
      public var weaponGenericId:uint = 0;
      
      public function GameActionFightCloseCombatMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2405;
      }
      
      public function initGameActionFightCloseCombatMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, destinationCellId:int = 0, critical:uint = 1, silentCast:Boolean = false, verboseCast:Boolean = false, weaponGenericId:uint = 0) : GameActionFightCloseCombatMessage
      {
         super.initAbstractGameActionFightTargetedAbilityMessage(actionId,sourceId,targetId,destinationCellId,critical,silentCast,verboseCast);
         this.weaponGenericId = weaponGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.weaponGenericId = 0;
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
         this.serializeAs_GameActionFightCloseCombatMessage(output);
      }
      
      public function serializeAs_GameActionFightCloseCombatMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
         if(this.weaponGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.weaponGenericId + ") on element weaponGenericId.");
         }
         output.writeVarInt(this.weaponGenericId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightCloseCombatMessage(input);
      }
      
      public function deserializeAs_GameActionFightCloseCombatMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._weaponGenericIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightCloseCombatMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightCloseCombatMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._weaponGenericIdFunc);
      }
      
      private function _weaponGenericIdFunc(input:ICustomDataInput) : void
      {
         this.weaponGenericId = input.readVarUhInt();
         if(this.weaponGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.weaponGenericId + ") on element of GameActionFightCloseCombatMessage.weaponGenericId.");
         }
      }
   }
}
