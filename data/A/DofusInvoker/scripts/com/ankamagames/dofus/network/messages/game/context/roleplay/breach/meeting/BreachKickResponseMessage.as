package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachKickResponseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6186;
       
      
      private var _isInitialized:Boolean = false;
      
      public var target:CharacterMinimalInformations;
      
      public var kicked:Boolean = false;
      
      private var _targettree:FuncTree;
      
      public function BreachKickResponseMessage()
      {
         this.target = new CharacterMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6186;
      }
      
      public function initBreachKickResponseMessage(target:CharacterMinimalInformations = null, kicked:Boolean = false) : BreachKickResponseMessage
      {
         this.target = target;
         this.kicked = kicked;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.target = new CharacterMinimalInformations();
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
         this.serializeAs_BreachKickResponseMessage(output);
      }
      
      public function serializeAs_BreachKickResponseMessage(output:ICustomDataOutput) : void
      {
         this.target.serializeAs_CharacterMinimalInformations(output);
         output.writeBoolean(this.kicked);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachKickResponseMessage(input);
      }
      
      public function deserializeAs_BreachKickResponseMessage(input:ICustomDataInput) : void
      {
         this.target = new CharacterMinimalInformations();
         this.target.deserialize(input);
         this._kickedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachKickResponseMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachKickResponseMessage(tree:FuncTree) : void
      {
         this._targettree = tree.addChild(this._targettreeFunc);
         tree.addChild(this._kickedFunc);
      }
      
      private function _targettreeFunc(input:ICustomDataInput) : void
      {
         this.target = new CharacterMinimalInformations();
         this.target.deserializeAsync(this._targettree);
      }
      
      private function _kickedFunc(input:ICustomDataInput) : void
      {
         this.kicked = input.readBoolean();
      }
   }
}
