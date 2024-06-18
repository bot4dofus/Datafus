package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightTriggerEffectMessage extends GameActionFightDispellEffectMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8838;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GameActionFightTriggerEffectMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8838;
      }
      
      public function initGameActionFightTriggerEffectMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, verboseCast:Boolean = false, boostUID:uint = 0) : GameActionFightTriggerEffectMessage
      {
         super.initGameActionFightDispellEffectMessage(actionId,sourceId,targetId,verboseCast,boostUID);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_GameActionFightTriggerEffectMessage(output);
      }
      
      public function serializeAs_GameActionFightTriggerEffectMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameActionFightDispellEffectMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightTriggerEffectMessage(input);
      }
      
      public function deserializeAs_GameActionFightTriggerEffectMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightTriggerEffectMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightTriggerEffectMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
