package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterSelectedSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4299;
       
      
      private var _isInitialized:Boolean = false;
      
      public var infos:CharacterBaseInformations;
      
      public var isCollectingStats:Boolean = false;
      
      private var _infostree:FuncTree;
      
      public function CharacterSelectedSuccessMessage()
      {
         this.infos = new CharacterBaseInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4299;
      }
      
      public function initCharacterSelectedSuccessMessage(infos:CharacterBaseInformations = null, isCollectingStats:Boolean = false) : CharacterSelectedSuccessMessage
      {
         this.infos = infos;
         this.isCollectingStats = isCollectingStats;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infos = new CharacterBaseInformations();
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
         this.serializeAs_CharacterSelectedSuccessMessage(output);
      }
      
      public function serializeAs_CharacterSelectedSuccessMessage(output:ICustomDataOutput) : void
      {
         this.infos.serializeAs_CharacterBaseInformations(output);
         output.writeBoolean(this.isCollectingStats);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSelectedSuccessMessage(input);
      }
      
      public function deserializeAs_CharacterSelectedSuccessMessage(input:ICustomDataInput) : void
      {
         this.infos = new CharacterBaseInformations();
         this.infos.deserialize(input);
         this._isCollectingStatsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterSelectedSuccessMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterSelectedSuccessMessage(tree:FuncTree) : void
      {
         this._infostree = tree.addChild(this._infostreeFunc);
         tree.addChild(this._isCollectingStatsFunc);
      }
      
      private function _infostreeFunc(input:ICustomDataInput) : void
      {
         this.infos = new CharacterBaseInformations();
         this.infos.deserializeAsync(this._infostree);
      }
      
      private function _isCollectingStatsFunc(input:ICustomDataInput) : void
      {
         this.isCollectingStats = input.readBoolean();
      }
   }
}
