package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameContextSummonsInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightMultipleSummonMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2358;
       
      
      private var _isInitialized:Boolean = false;
      
      public var summons:Vector.<GameContextSummonsInformation>;
      
      private var _summonstree:FuncTree;
      
      public function GameActionFightMultipleSummonMessage()
      {
         this.summons = new Vector.<GameContextSummonsInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2358;
      }
      
      public function initGameActionFightMultipleSummonMessage(actionId:uint = 0, sourceId:Number = 0, summons:Vector.<GameContextSummonsInformation> = null) : GameActionFightMultipleSummonMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.summons = summons;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.summons = new Vector.<GameContextSummonsInformation>();
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
         this.serializeAs_GameActionFightMultipleSummonMessage(output);
      }
      
      public function serializeAs_GameActionFightMultipleSummonMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.summons.length);
         for(var _i1:uint = 0; _i1 < this.summons.length; _i1++)
         {
            output.writeShort((this.summons[_i1] as GameContextSummonsInformation).getTypeId());
            (this.summons[_i1] as GameContextSummonsInformation).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightMultipleSummonMessage(input);
      }
      
      public function deserializeAs_GameActionFightMultipleSummonMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:GameContextSummonsInformation = null;
         super.deserialize(input);
         var _summonsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _summonsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(GameContextSummonsInformation,_id1);
            _item1.deserialize(input);
            this.summons.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightMultipleSummonMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightMultipleSummonMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._summonstree = tree.addChild(this._summonstreeFunc);
      }
      
      private function _summonstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._summonstree.addChild(this._summonsFunc);
         }
      }
      
      private function _summonsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GameContextSummonsInformation = ProtocolTypeManager.getInstance(GameContextSummonsInformation,_id);
         _item.deserialize(input);
         this.summons.push(_item);
      }
   }
}
