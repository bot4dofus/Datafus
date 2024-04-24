package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightDispellEffectMessage extends GameActionFightDispellMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9093;
       
      
      private var _isInitialized:Boolean = false;
      
      public var boostUID:uint = 0;
      
      public function GameActionFightDispellEffectMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9093;
      }
      
      public function initGameActionFightDispellEffectMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, verboseCast:Boolean = false, boostUID:uint = 0) : GameActionFightDispellEffectMessage
      {
         super.initGameActionFightDispellMessage(actionId,sourceId,targetId,verboseCast);
         this.boostUID = boostUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.boostUID = 0;
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
         this.serializeAs_GameActionFightDispellEffectMessage(output);
      }
      
      public function serializeAs_GameActionFightDispellEffectMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameActionFightDispellMessage(output);
         if(this.boostUID < 0)
         {
            throw new Error("Forbidden value (" + this.boostUID + ") on element boostUID.");
         }
         output.writeInt(this.boostUID);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightDispellEffectMessage(input);
      }
      
      public function deserializeAs_GameActionFightDispellEffectMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._boostUIDFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightDispellEffectMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightDispellEffectMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._boostUIDFunc);
      }
      
      private function _boostUIDFunc(input:ICustomDataInput) : void
      {
         this.boostUID = input.readInt();
         if(this.boostUID < 0)
         {
            throw new Error("Forbidden value (" + this.boostUID + ") on element of GameActionFightDispellEffectMessage.boostUID.");
         }
      }
   }
}
