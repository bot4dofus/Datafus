package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceInsiderPrismInformation extends PrismInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5890;
       
      
      public var lastTimeSlotModificationDate:uint = 0;
      
      public var lastTimeSlotModificationAuthorGuildId:uint = 0;
      
      public var lastTimeSlotModificationAuthorId:Number = 0;
      
      public var lastTimeSlotModificationAuthorName:String = "";
      
      public var modulesObjects:Vector.<ObjectItem>;
      
      private var _modulesObjectstree:FuncTree;
      
      public function AllianceInsiderPrismInformation()
      {
         this.modulesObjects = new Vector.<ObjectItem>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5890;
      }
      
      public function initAllianceInsiderPrismInformation(typeId:uint = 0, state:uint = 1, nextVulnerabilityDate:uint = 0, placementDate:uint = 0, rewardTokenCount:uint = 0, lastTimeSlotModificationDate:uint = 0, lastTimeSlotModificationAuthorGuildId:uint = 0, lastTimeSlotModificationAuthorId:Number = 0, lastTimeSlotModificationAuthorName:String = "", modulesObjects:Vector.<ObjectItem> = null) : AllianceInsiderPrismInformation
      {
         super.initPrismInformation(typeId,state,nextVulnerabilityDate,placementDate,rewardTokenCount);
         this.lastTimeSlotModificationDate = lastTimeSlotModificationDate;
         this.lastTimeSlotModificationAuthorGuildId = lastTimeSlotModificationAuthorGuildId;
         this.lastTimeSlotModificationAuthorId = lastTimeSlotModificationAuthorId;
         this.lastTimeSlotModificationAuthorName = lastTimeSlotModificationAuthorName;
         this.modulesObjects = modulesObjects;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.lastTimeSlotModificationDate = 0;
         this.lastTimeSlotModificationAuthorGuildId = 0;
         this.lastTimeSlotModificationAuthorId = 0;
         this.lastTimeSlotModificationAuthorName = "";
         this.modulesObjects = new Vector.<ObjectItem>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceInsiderPrismInformation(output);
      }
      
      public function serializeAs_AllianceInsiderPrismInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_PrismInformation(output);
         if(this.lastTimeSlotModificationDate < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationDate + ") on element lastTimeSlotModificationDate.");
         }
         output.writeInt(this.lastTimeSlotModificationDate);
         if(this.lastTimeSlotModificationAuthorGuildId < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorGuildId + ") on element lastTimeSlotModificationAuthorGuildId.");
         }
         output.writeVarInt(this.lastTimeSlotModificationAuthorGuildId);
         if(this.lastTimeSlotModificationAuthorId < 0 || this.lastTimeSlotModificationAuthorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorId + ") on element lastTimeSlotModificationAuthorId.");
         }
         output.writeVarLong(this.lastTimeSlotModificationAuthorId);
         output.writeUTF(this.lastTimeSlotModificationAuthorName);
         output.writeShort(this.modulesObjects.length);
         for(var _i5:uint = 0; _i5 < this.modulesObjects.length; _i5++)
         {
            (this.modulesObjects[_i5] as ObjectItem).serializeAs_ObjectItem(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInsiderPrismInformation(input);
      }
      
      public function deserializeAs_AllianceInsiderPrismInformation(input:ICustomDataInput) : void
      {
         var _item5:ObjectItem = null;
         super.deserialize(input);
         this._lastTimeSlotModificationDateFunc(input);
         this._lastTimeSlotModificationAuthorGuildIdFunc(input);
         this._lastTimeSlotModificationAuthorIdFunc(input);
         this._lastTimeSlotModificationAuthorNameFunc(input);
         var _modulesObjectsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _modulesObjectsLen; _i5++)
         {
            _item5 = new ObjectItem();
            _item5.deserialize(input);
            this.modulesObjects.push(_item5);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInsiderPrismInformation(tree);
      }
      
      public function deserializeAsyncAs_AllianceInsiderPrismInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._lastTimeSlotModificationDateFunc);
         tree.addChild(this._lastTimeSlotModificationAuthorGuildIdFunc);
         tree.addChild(this._lastTimeSlotModificationAuthorIdFunc);
         tree.addChild(this._lastTimeSlotModificationAuthorNameFunc);
         this._modulesObjectstree = tree.addChild(this._modulesObjectstreeFunc);
      }
      
      private function _lastTimeSlotModificationDateFunc(input:ICustomDataInput) : void
      {
         this.lastTimeSlotModificationDate = input.readInt();
         if(this.lastTimeSlotModificationDate < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationDate + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationDate.");
         }
      }
      
      private function _lastTimeSlotModificationAuthorGuildIdFunc(input:ICustomDataInput) : void
      {
         this.lastTimeSlotModificationAuthorGuildId = input.readVarUhInt();
         if(this.lastTimeSlotModificationAuthorGuildId < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorGuildId + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationAuthorGuildId.");
         }
      }
      
      private function _lastTimeSlotModificationAuthorIdFunc(input:ICustomDataInput) : void
      {
         this.lastTimeSlotModificationAuthorId = input.readVarUhLong();
         if(this.lastTimeSlotModificationAuthorId < 0 || this.lastTimeSlotModificationAuthorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorId + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationAuthorId.");
         }
      }
      
      private function _lastTimeSlotModificationAuthorNameFunc(input:ICustomDataInput) : void
      {
         this.lastTimeSlotModificationAuthorName = input.readUTF();
      }
      
      private function _modulesObjectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._modulesObjectstree.addChild(this._modulesObjectsFunc);
         }
      }
      
      private function _modulesObjectsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItem = new ObjectItem();
         _item.deserialize(input);
         this.modulesObjects.push(_item);
      }
   }
}
