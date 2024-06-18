package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockInformationsForSell implements INetworkType
   {
      
      public static const protocolId:uint = 5311;
       
      
      public var guildOwner:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var nbMount:int = 0;
      
      public var nbObject:int = 0;
      
      public var price:Number = 0;
      
      public function PaddockInformationsForSell()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5311;
      }
      
      public function initPaddockInformationsForSell(guildOwner:String = "", worldX:int = 0, worldY:int = 0, subAreaId:uint = 0, nbMount:int = 0, nbObject:int = 0, price:Number = 0) : PaddockInformationsForSell
      {
         this.guildOwner = guildOwner;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.nbMount = nbMount;
         this.nbObject = nbObject;
         this.price = price;
         return this;
      }
      
      public function reset() : void
      {
         this.guildOwner = "";
         this.worldX = 0;
         this.worldY = 0;
         this.subAreaId = 0;
         this.nbMount = 0;
         this.nbObject = 0;
         this.price = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockInformationsForSell(output);
      }
      
      public function serializeAs_PaddockInformationsForSell(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.guildOwner);
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
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeByte(this.nbMount);
         output.writeByte(this.nbObject);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockInformationsForSell(input);
      }
      
      public function deserializeAs_PaddockInformationsForSell(input:ICustomDataInput) : void
      {
         this._guildOwnerFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._subAreaIdFunc(input);
         this._nbMountFunc(input);
         this._nbObjectFunc(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockInformationsForSell(tree);
      }
      
      public function deserializeAsyncAs_PaddockInformationsForSell(tree:FuncTree) : void
      {
         tree.addChild(this._guildOwnerFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._nbMountFunc);
         tree.addChild(this._nbObjectFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function _guildOwnerFunc(input:ICustomDataInput) : void
      {
         this.guildOwner = input.readUTF();
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockInformationsForSell.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockInformationsForSell.worldY.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockInformationsForSell.subAreaId.");
         }
      }
      
      private function _nbMountFunc(input:ICustomDataInput) : void
      {
         this.nbMount = input.readByte();
      }
      
      private function _nbObjectFunc(input:ICustomDataInput) : void
      {
         this.nbObject = input.readByte();
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockInformationsForSell.price.");
         }
      }
   }
}
