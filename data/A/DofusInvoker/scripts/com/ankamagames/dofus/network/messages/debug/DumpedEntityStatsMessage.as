package com.ankamagames.dofus.network.messages.debug
{
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristics;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DumpedEntityStatsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2370;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actorId:Number = 0;
      
      public var stats:CharacterCharacteristics;
      
      private var _statstree:FuncTree;
      
      public function DumpedEntityStatsMessage()
      {
         this.stats = new CharacterCharacteristics();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2370;
      }
      
      public function initDumpedEntityStatsMessage(actorId:Number = 0, stats:CharacterCharacteristics = null) : DumpedEntityStatsMessage
      {
         this.actorId = actorId;
         this.stats = stats;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actorId = 0;
         this.stats = new CharacterCharacteristics();
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
         this.serializeAs_DumpedEntityStatsMessage(output);
      }
      
      public function serializeAs_DumpedEntityStatsMessage(output:ICustomDataOutput) : void
      {
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element actorId.");
         }
         output.writeDouble(this.actorId);
         this.stats.serializeAs_CharacterCharacteristics(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DumpedEntityStatsMessage(input);
      }
      
      public function deserializeAs_DumpedEntityStatsMessage(input:ICustomDataInput) : void
      {
         this._actorIdFunc(input);
         this.stats = new CharacterCharacteristics();
         this.stats.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DumpedEntityStatsMessage(tree);
      }
      
      public function deserializeAsyncAs_DumpedEntityStatsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actorIdFunc);
         this._statstree = tree.addChild(this._statstreeFunc);
      }
      
      private function _actorIdFunc(input:ICustomDataInput) : void
      {
         this.actorId = input.readDouble();
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element of DumpedEntityStatsMessage.actorId.");
         }
      }
      
      private function _statstreeFunc(input:ICustomDataInput) : void
      {
         this.stats = new CharacterCharacteristics();
         this.stats.deserializeAsync(this._statstree);
      }
   }
}
