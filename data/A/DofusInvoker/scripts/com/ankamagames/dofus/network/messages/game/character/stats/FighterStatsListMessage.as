package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FighterStatsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4354;
       
      
      private var _isInitialized:Boolean = false;
      
      public var stats:CharacterCharacteristicsInformations;
      
      private var _statstree:FuncTree;
      
      public function FighterStatsListMessage()
      {
         this.stats = new CharacterCharacteristicsInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4354;
      }
      
      public function initFighterStatsListMessage(stats:CharacterCharacteristicsInformations = null) : FighterStatsListMessage
      {
         this.stats = stats;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.stats = new CharacterCharacteristicsInformations();
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
         this.serializeAs_FighterStatsListMessage(output);
      }
      
      public function serializeAs_FighterStatsListMessage(output:ICustomDataOutput) : void
      {
         this.stats.serializeAs_CharacterCharacteristicsInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FighterStatsListMessage(input);
      }
      
      public function deserializeAs_FighterStatsListMessage(input:ICustomDataInput) : void
      {
         this.stats = new CharacterCharacteristicsInformations();
         this.stats.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FighterStatsListMessage(tree);
      }
      
      public function deserializeAsyncAs_FighterStatsListMessage(tree:FuncTree) : void
      {
         this._statstree = tree.addChild(this._statstreeFunc);
      }
      
      private function _statstreeFunc(input:ICustomDataInput) : void
      {
         this.stats = new CharacterCharacteristicsInformations();
         this.stats.deserializeAsync(this._statstree);
      }
   }
}
