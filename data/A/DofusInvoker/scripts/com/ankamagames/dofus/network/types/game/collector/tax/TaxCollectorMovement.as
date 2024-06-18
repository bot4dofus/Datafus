package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorMovement implements INetworkType
   {
      
      public static const protocolId:uint = 7487;
       
      
      public var movementType:uint = 0;
      
      public var basicInfos:TaxCollectorBasicInformations;
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      private var _basicInfostree:FuncTree;
      
      public function TaxCollectorMovement()
      {
         this.basicInfos = new TaxCollectorBasicInformations();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7487;
      }
      
      public function initTaxCollectorMovement(movementType:uint = 0, basicInfos:TaxCollectorBasicInformations = null, playerId:Number = 0, playerName:String = "") : TaxCollectorMovement
      {
         this.movementType = movementType;
         this.basicInfos = basicInfos;
         this.playerId = playerId;
         this.playerName = playerName;
         return this;
      }
      
      public function reset() : void
      {
         this.movementType = 0;
         this.basicInfos = new TaxCollectorBasicInformations();
         this.playerName = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorMovement(output);
      }
      
      public function serializeAs_TaxCollectorMovement(output:ICustomDataOutput) : void
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
         this.deserializeAs_TaxCollectorMovement(input);
      }
      
      public function deserializeAs_TaxCollectorMovement(input:ICustomDataInput) : void
      {
         this._movementTypeFunc(input);
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorMovement(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorMovement(tree:FuncTree) : void
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
            throw new Error("Forbidden value (" + this.movementType + ") on element of TaxCollectorMovement.movementType.");
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
            throw new Error("Forbidden value (" + this.playerId + ") on element of TaxCollectorMovement.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
   }
}
