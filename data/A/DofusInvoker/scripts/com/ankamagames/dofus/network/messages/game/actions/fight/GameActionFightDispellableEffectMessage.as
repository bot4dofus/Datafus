package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightDispellableEffectMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3071;
       
      
      private var _isInitialized:Boolean = false;
      
      public var effect:AbstractFightDispellableEffect;
      
      private var _effecttree:FuncTree;
      
      public function GameActionFightDispellableEffectMessage()
      {
         this.effect = new AbstractFightDispellableEffect();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3071;
      }
      
      public function initGameActionFightDispellableEffectMessage(actionId:uint = 0, sourceId:Number = 0, effect:AbstractFightDispellableEffect = null) : GameActionFightDispellableEffectMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.effect = effect;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.effect = new AbstractFightDispellableEffect();
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
         this.serializeAs_GameActionFightDispellableEffectMessage(output);
      }
      
      public function serializeAs_GameActionFightDispellableEffectMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.effect.getTypeId());
         this.effect.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightDispellableEffectMessage(input);
      }
      
      public function deserializeAs_GameActionFightDispellableEffectMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_id1);
         this.effect.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightDispellableEffectMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightDispellableEffectMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._effecttree = tree.addChild(this._effecttreeFunc);
      }
      
      private function _effecttreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect,_id);
         this.effect.deserializeAsync(this._effecttree);
      }
   }
}
