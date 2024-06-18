package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AdditionalTaxCollectorInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1456;
       
      
      public var collectorCallerId:Number = 0;
      
      public var collectorCallerName:String = "";
      
      public var date:uint = 0;
      
      public function AdditionalTaxCollectorInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1456;
      }
      
      public function initAdditionalTaxCollectorInformation(collectorCallerId:Number = 0, collectorCallerName:String = "", date:uint = 0) : AdditionalTaxCollectorInformation
      {
         this.collectorCallerId = collectorCallerId;
         this.collectorCallerName = collectorCallerName;
         this.date = date;
         return this;
      }
      
      public function reset() : void
      {
         this.collectorCallerId = 0;
         this.collectorCallerName = "";
         this.date = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AdditionalTaxCollectorInformation(output);
      }
      
      public function serializeAs_AdditionalTaxCollectorInformation(output:ICustomDataOutput) : void
      {
         if(this.collectorCallerId < 0 || this.collectorCallerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.collectorCallerId + ") on element collectorCallerId.");
         }
         output.writeVarLong(this.collectorCallerId);
         output.writeUTF(this.collectorCallerName);
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element date.");
         }
         output.writeInt(this.date);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AdditionalTaxCollectorInformation(input);
      }
      
      public function deserializeAs_AdditionalTaxCollectorInformation(input:ICustomDataInput) : void
      {
         this._collectorCallerIdFunc(input);
         this._collectorCallerNameFunc(input);
         this._dateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AdditionalTaxCollectorInformation(tree);
      }
      
      public function deserializeAsyncAs_AdditionalTaxCollectorInformation(tree:FuncTree) : void
      {
         tree.addChild(this._collectorCallerIdFunc);
         tree.addChild(this._collectorCallerNameFunc);
         tree.addChild(this._dateFunc);
      }
      
      private function _collectorCallerIdFunc(input:ICustomDataInput) : void
      {
         this.collectorCallerId = input.readVarUhLong();
         if(this.collectorCallerId < 0 || this.collectorCallerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.collectorCallerId + ") on element of AdditionalTaxCollectorInformation.collectorCallerId.");
         }
      }
      
      private function _collectorCallerNameFunc(input:ICustomDataInput) : void
      {
         this.collectorCallerName = input.readUTF();
      }
      
      private function _dateFunc(input:ICustomDataInput) : void
      {
         this.date = input.readInt();
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element of AdditionalTaxCollectorInformation.date.");
         }
      }
   }
}
