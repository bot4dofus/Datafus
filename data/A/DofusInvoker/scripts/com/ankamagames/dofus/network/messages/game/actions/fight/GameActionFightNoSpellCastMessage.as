package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightNoSpellCastMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8870;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellLevelId:uint = 0;
      
      public function GameActionFightNoSpellCastMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8870;
      }
      
      public function initGameActionFightNoSpellCastMessage(spellLevelId:uint = 0) : GameActionFightNoSpellCastMessage
      {
         this.spellLevelId = spellLevelId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellLevelId = 0;
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
         this.serializeAs_GameActionFightNoSpellCastMessage(output);
      }
      
      public function serializeAs_GameActionFightNoSpellCastMessage(output:ICustomDataOutput) : void
      {
         if(this.spellLevelId < 0)
         {
            throw new Error("Forbidden value (" + this.spellLevelId + ") on element spellLevelId.");
         }
         output.writeVarInt(this.spellLevelId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightNoSpellCastMessage(input);
      }
      
      public function deserializeAs_GameActionFightNoSpellCastMessage(input:ICustomDataInput) : void
      {
         this._spellLevelIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightNoSpellCastMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightNoSpellCastMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellLevelIdFunc);
      }
      
      private function _spellLevelIdFunc(input:ICustomDataInput) : void
      {
         this.spellLevelId = input.readVarUhInt();
         if(this.spellLevelId < 0)
         {
            throw new Error("Forbidden value (" + this.spellLevelId + ") on element of GameActionFightNoSpellCastMessage.spellLevelId.");
         }
      }
   }
}
