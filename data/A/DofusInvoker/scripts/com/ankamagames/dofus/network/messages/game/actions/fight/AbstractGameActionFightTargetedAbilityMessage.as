package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AbstractGameActionFightTargetedAbilityMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5172;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var destinationCellId:int = 0;
      
      public var critical:uint = 1;
      
      public var silentCast:Boolean = false;
      
      public var verboseCast:Boolean = false;
      
      public function AbstractGameActionFightTargetedAbilityMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5172;
      }
      
      public function initAbstractGameActionFightTargetedAbilityMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, destinationCellId:int = 0, critical:uint = 1, silentCast:Boolean = false, verboseCast:Boolean = false) : AbstractGameActionFightTargetedAbilityMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.destinationCellId = destinationCellId;
         this.critical = critical;
         this.silentCast = silentCast;
         this.verboseCast = verboseCast;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.destinationCellId = 0;
         this.critical = 1;
         this.silentCast = false;
         this.verboseCast = false;
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
         this.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
      }
      
      public function serializeAs_AbstractGameActionFightTargetedAbilityMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.silentCast);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.verboseCast);
         output.writeByte(_box0);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.destinationCellId < -1 || this.destinationCellId > 559)
         {
            throw new Error("Forbidden value (" + this.destinationCellId + ") on element destinationCellId.");
         }
         output.writeShort(this.destinationCellId);
         output.writeByte(this.critical);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractGameActionFightTargetedAbilityMessage(input);
      }
      
      public function deserializeAs_AbstractGameActionFightTargetedAbilityMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._targetIdFunc(input);
         this._destinationCellIdFunc(input);
         this._criticalFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractGameActionFightTargetedAbilityMessage(tree);
      }
      
      public function deserializeAsyncAs_AbstractGameActionFightTargetedAbilityMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._destinationCellIdFunc);
         tree.addChild(this._criticalFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.silentCast = BooleanByteWrapper.getFlag(_box0,0);
         this.verboseCast = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of AbstractGameActionFightTargetedAbilityMessage.targetId.");
         }
      }
      
      private function _destinationCellIdFunc(input:ICustomDataInput) : void
      {
         this.destinationCellId = input.readShort();
         if(this.destinationCellId < -1 || this.destinationCellId > 559)
         {
            throw new Error("Forbidden value (" + this.destinationCellId + ") on element of AbstractGameActionFightTargetedAbilityMessage.destinationCellId.");
         }
      }
      
      private function _criticalFunc(input:ICustomDataInput) : void
      {
         this.critical = input.readByte();
         if(this.critical < 0)
         {
            throw new Error("Forbidden value (" + this.critical + ") on element of AbstractGameActionFightTargetedAbilityMessage.critical.");
         }
      }
   }
}
