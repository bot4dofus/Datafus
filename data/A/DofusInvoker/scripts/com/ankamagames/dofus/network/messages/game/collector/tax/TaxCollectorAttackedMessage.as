package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorAttackedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5361;
       
      
      private var _isInitialized:Boolean = false;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var alliance:BasicAllianceInformations;
      
      private var _alliancetree:FuncTree;
      
      public function TaxCollectorAttackedMessage()
      {
         this.alliance = new BasicAllianceInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5361;
      }
      
      public function initTaxCollectorAttackedMessage(firstNameId:uint = 0, lastNameId:uint = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, alliance:BasicAllianceInformations = null) : TaxCollectorAttackedMessage
      {
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.alliance = alliance;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.alliance = new BasicAllianceInformations();
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
         this.serializeAs_TaxCollectorAttackedMessage(output);
      }
      
      public function serializeAs_TaxCollectorAttackedMessage(output:ICustomDataOutput) : void
      {
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         output.writeVarShort(this.firstNameId);
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
         }
         output.writeVarShort(this.lastNameId);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         this.alliance.serializeAs_BasicAllianceInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorAttackedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorAttackedMessage(input:ICustomDataInput) : void
      {
         this._firstNameIdFunc(input);
         this._lastNameIdFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         this.alliance = new BasicAllianceInformations();
         this.alliance.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorAttackedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorAttackedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._firstNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         this._alliancetree = tree.addChild(this._alliancetreeFunc);
      }
      
      private function _firstNameIdFunc(input:ICustomDataInput) : void
      {
         this.firstNameId = input.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of TaxCollectorAttackedMessage.firstNameId.");
         }
      }
      
      private function _lastNameIdFunc(input:ICustomDataInput) : void
      {
         this.lastNameId = input.readVarUhShort();
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorAttackedMessage.lastNameId.");
         }
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorAttackedMessage.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorAttackedMessage.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of TaxCollectorAttackedMessage.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorAttackedMessage.subAreaId.");
         }
      }
      
      private function _alliancetreeFunc(input:ICustomDataInput) : void
      {
         this.alliance = new BasicAllianceInformations();
         this.alliance.deserializeAsync(this._alliancetree);
      }
   }
}
