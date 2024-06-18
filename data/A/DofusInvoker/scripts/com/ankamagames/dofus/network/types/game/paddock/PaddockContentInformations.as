package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockContentInformations extends PaddockInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6426;
       
      
      public var paddockId:Number = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var abandonned:Boolean = false;
      
      public var mountsInformations:Vector.<MountInformationsForPaddock>;
      
      private var _mountsInformationstree:FuncTree;
      
      public function PaddockContentInformations()
      {
         this.mountsInformations = new Vector.<MountInformationsForPaddock>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6426;
      }
      
      public function initPaddockContentInformations(maxOutdoorMount:uint = 0, maxItems:uint = 0, paddockId:Number = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, abandonned:Boolean = false, mountsInformations:Vector.<MountInformationsForPaddock> = null) : PaddockContentInformations
      {
         super.initPaddockInformations(maxOutdoorMount,maxItems);
         this.paddockId = paddockId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.abandonned = abandonned;
         this.mountsInformations = mountsInformations;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.paddockId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.abandonned = false;
         this.mountsInformations = new Vector.<MountInformationsForPaddock>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockContentInformations(output);
      }
      
      public function serializeAs_PaddockContentInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaddockInformations(output);
         if(this.paddockId < 0 || this.paddockId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element paddockId.");
         }
         output.writeDouble(this.paddockId);
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
         output.writeBoolean(this.abandonned);
         output.writeShort(this.mountsInformations.length);
         for(var _i7:uint = 0; _i7 < this.mountsInformations.length; _i7++)
         {
            (this.mountsInformations[_i7] as MountInformationsForPaddock).serializeAs_MountInformationsForPaddock(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockContentInformations(input);
      }
      
      public function deserializeAs_PaddockContentInformations(input:ICustomDataInput) : void
      {
         var _item7:MountInformationsForPaddock = null;
         super.deserialize(input);
         this._paddockIdFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         this._abandonnedFunc(input);
         var _mountsInformationsLen:uint = input.readUnsignedShort();
         for(var _i7:uint = 0; _i7 < _mountsInformationsLen; _i7++)
         {
            _item7 = new MountInformationsForPaddock();
            _item7.deserialize(input);
            this.mountsInformations.push(_item7);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockContentInformations(tree);
      }
      
      public function deserializeAsyncAs_PaddockContentInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._paddockIdFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._abandonnedFunc);
         this._mountsInformationstree = tree.addChild(this._mountsInformationstreeFunc);
      }
      
      private function _paddockIdFunc(input:ICustomDataInput) : void
      {
         this.paddockId = input.readDouble();
         if(this.paddockId < 0 || this.paddockId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element of PaddockContentInformations.paddockId.");
         }
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockContentInformations.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockContentInformations.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of PaddockContentInformations.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockContentInformations.subAreaId.");
         }
      }
      
      private function _abandonnedFunc(input:ICustomDataInput) : void
      {
         this.abandonned = input.readBoolean();
      }
      
      private function _mountsInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._mountsInformationstree.addChild(this._mountsInformationsFunc);
         }
      }
      
      private function _mountsInformationsFunc(input:ICustomDataInput) : void
      {
         var _item:MountInformationsForPaddock = new MountInformationsForPaddock();
         _item.deserialize(input);
         this.mountsInformations.push(_item);
      }
   }
}
