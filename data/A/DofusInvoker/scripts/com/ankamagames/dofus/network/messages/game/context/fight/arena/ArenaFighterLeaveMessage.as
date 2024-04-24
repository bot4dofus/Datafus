package com.ankamagames.dofus.network.messages.game.context.fight.arena
{
   import com.ankamagames.dofus.network.types.game.character.CharacterBasicMinimalInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ArenaFighterLeaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1144;
       
      
      private var _isInitialized:Boolean = false;
      
      public var leaver:CharacterBasicMinimalInformations;
      
      private var _leavertree:FuncTree;
      
      public function ArenaFighterLeaveMessage()
      {
         this.leaver = new CharacterBasicMinimalInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1144;
      }
      
      public function initArenaFighterLeaveMessage(leaver:CharacterBasicMinimalInformations = null) : ArenaFighterLeaveMessage
      {
         this.leaver = leaver;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.leaver = new CharacterBasicMinimalInformations();
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
         this.serializeAs_ArenaFighterLeaveMessage(output);
      }
      
      public function serializeAs_ArenaFighterLeaveMessage(output:ICustomDataOutput) : void
      {
         this.leaver.serializeAs_CharacterBasicMinimalInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ArenaFighterLeaveMessage(input);
      }
      
      public function deserializeAs_ArenaFighterLeaveMessage(input:ICustomDataInput) : void
      {
         this.leaver = new CharacterBasicMinimalInformations();
         this.leaver.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaFighterLeaveMessage(tree);
      }
      
      public function deserializeAsyncAs_ArenaFighterLeaveMessage(tree:FuncTree) : void
      {
         this._leavertree = tree.addChild(this._leavertreeFunc);
      }
      
      private function _leavertreeFunc(input:ICustomDataInput) : void
      {
         this.leaver = new CharacterBasicMinimalInformations();
         this.leaver.deserializeAsync(this._leavertree);
      }
   }
}
