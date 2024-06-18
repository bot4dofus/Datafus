package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightHumanReadyStateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 109;
       
      
      private var _isInitialized:Boolean = false;
      
      public var characterId:Number = 0;
      
      public var isReady:Boolean = false;
      
      public function GameFightHumanReadyStateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 109;
      }
      
      public function initGameFightHumanReadyStateMessage(characterId:Number = 0, isReady:Boolean = false) : GameFightHumanReadyStateMessage
      {
         this.characterId = characterId;
         this.isReady = isReady;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.characterId = 0;
         this.isReady = false;
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
         this.serializeAs_GameFightHumanReadyStateMessage(output);
      }
      
      public function serializeAs_GameFightHumanReadyStateMessage(output:ICustomDataOutput) : void
      {
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         output.writeVarLong(this.characterId);
         output.writeBoolean(this.isReady);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightHumanReadyStateMessage(input);
      }
      
      public function deserializeAs_GameFightHumanReadyStateMessage(input:ICustomDataInput) : void
      {
         this._characterIdFunc(input);
         this._isReadyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightHumanReadyStateMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightHumanReadyStateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._characterIdFunc);
         tree.addChild(this._isReadyFunc);
      }
      
      private function _characterIdFunc(input:ICustomDataInput) : void
      {
         this.characterId = input.readVarUhLong();
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of GameFightHumanReadyStateMessage.characterId.");
         }
      }
      
      private function _isReadyFunc(input:ICustomDataInput) : void
      {
         this.isReady = input.readBoolean();
      }
   }
}
