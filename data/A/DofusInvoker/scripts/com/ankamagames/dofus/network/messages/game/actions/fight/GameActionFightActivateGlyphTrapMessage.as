package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightActivateGlyphTrapMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5706;
       
      
      private var _isInitialized:Boolean = false;
      
      public var markId:int = 0;
      
      public var active:Boolean = false;
      
      public function GameActionFightActivateGlyphTrapMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5706;
      }
      
      public function initGameActionFightActivateGlyphTrapMessage(actionId:uint = 0, sourceId:Number = 0, markId:int = 0, active:Boolean = false) : GameActionFightActivateGlyphTrapMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.markId = markId;
         this.active = active;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.markId = 0;
         this.active = false;
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
         this.serializeAs_GameActionFightActivateGlyphTrapMessage(output);
      }
      
      public function serializeAs_GameActionFightActivateGlyphTrapMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.markId);
         output.writeBoolean(this.active);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightActivateGlyphTrapMessage(input);
      }
      
      public function deserializeAs_GameActionFightActivateGlyphTrapMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._markIdFunc(input);
         this._activeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightActivateGlyphTrapMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightActivateGlyphTrapMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._markIdFunc);
         tree.addChild(this._activeFunc);
      }
      
      private function _markIdFunc(input:ICustomDataInput) : void
      {
         this.markId = input.readShort();
      }
      
      private function _activeFunc(input:ICustomDataInput) : void
      {
         this.active = input.readBoolean();
      }
   }
}
