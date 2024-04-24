package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionObjectUse extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 6762;
       
      
      public var delayTypeId:uint = 0;
      
      public var delayEndTime:Number = 0;
      
      public var objectGID:uint = 0;
      
      public function HumanOptionObjectUse()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6762;
      }
      
      public function initHumanOptionObjectUse(delayTypeId:uint = 0, delayEndTime:Number = 0, objectGID:uint = 0) : HumanOptionObjectUse
      {
         this.delayTypeId = delayTypeId;
         this.delayEndTime = delayEndTime;
         this.objectGID = objectGID;
         return this;
      }
      
      override public function reset() : void
      {
         this.delayTypeId = 0;
         this.delayEndTime = 0;
         this.objectGID = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionObjectUse(output);
      }
      
      public function serializeAs_HumanOptionObjectUse(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         output.writeByte(this.delayTypeId);
         if(this.delayEndTime < 0 || this.delayEndTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element delayEndTime.");
         }
         output.writeDouble(this.delayEndTime);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionObjectUse(input);
      }
      
      public function deserializeAs_HumanOptionObjectUse(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._delayTypeIdFunc(input);
         this._delayEndTimeFunc(input);
         this._objectGIDFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionObjectUse(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionObjectUse(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._delayTypeIdFunc);
         tree.addChild(this._delayEndTimeFunc);
         tree.addChild(this._objectGIDFunc);
      }
      
      private function _delayTypeIdFunc(input:ICustomDataInput) : void
      {
         this.delayTypeId = input.readByte();
         if(this.delayTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.delayTypeId + ") on element of HumanOptionObjectUse.delayTypeId.");
         }
      }
      
      private function _delayEndTimeFunc(input:ICustomDataInput) : void
      {
         this.delayEndTime = input.readDouble();
         if(this.delayEndTime < 0 || this.delayEndTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element of HumanOptionObjectUse.delayEndTime.");
         }
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of HumanOptionObjectUse.objectGID.");
         }
      }
   }
}
