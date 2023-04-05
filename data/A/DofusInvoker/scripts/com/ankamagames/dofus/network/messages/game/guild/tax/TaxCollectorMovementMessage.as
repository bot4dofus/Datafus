package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorBasicInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5589;
       
      
      private var _isInitialized:Boolean = false;
      
      public var movementType:uint = 0;
      
      public var basicInfos:TaxCollectorBasicInformations;
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      private var _basicInfostree:FuncTree;
      
      public function TaxCollectorMovementMessage()
      {
         this.basicInfos = new TaxCollectorBasicInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5589;
      }
      
      public function initTaxCollectorMovementMessage(movementType:uint = 0, basicInfos:TaxCollectorBasicInformations = null, playerId:Number = 0, playerName:String = "") : TaxCollectorMovementMessage
      {
         this.movementType = movementType;
         this.basicInfos = basicInfos;
         this.playerId = playerId;
         this.playerName = playerName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.movementType = 0;
         this.basicInfos = new TaxCollectorBasicInformations();
         this.playerName = "";
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
         this.serializeAs_TaxCollectorMovementMessage(output);
      }
      
      public function serializeAs_TaxCollectorMovementMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.movementType);
         this.basicInfos.serializeAs_TaxCollectorBasicInformations(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorMovementMessage(input);
      }
      
      public function deserializeAs_TaxCollectorMovementMessage(input:ICustomDataInput) : void
      {
         this._movementTypeFunc(input);
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorMovementMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorMovementMessage(tree:FuncTree) : void
      {
         tree.addChild(this._movementTypeFunc);
         this._basicInfostree = tree.addChild(this._basicInfostreeFunc);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
      }
      
      private function _movementTypeFunc(input:ICustomDataInput) : void
      {
         this.movementType = input.readByte();
         if(this.movementType < 0)
         {
            throw new Error("Forbidden value (" + this.movementType + ") on element of TaxCollectorMovementMessage.movementType.");
         }
      }
      
      private function _basicInfostreeFunc(input:ICustomDataInput) : void
      {
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserializeAsync(this._basicInfostree);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of TaxCollectorMovementMessage.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
   }
}
