package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AdditionalTaxCollectorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5519;
       
      
      public var collectorCallerName:String = "";
      
      public var date:uint = 0;
      
      public function AdditionalTaxCollectorInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5519;
      }
      
      public function initAdditionalTaxCollectorInformations(collectorCallerName:String = "", date:uint = 0) : AdditionalTaxCollectorInformations
      {
         this.collectorCallerName = collectorCallerName;
         this.date = date;
         return this;
      }
      
      public function reset() : void
      {
         this.collectorCallerName = "";
         this.date = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AdditionalTaxCollectorInformations(output);
      }
      
      public function serializeAs_AdditionalTaxCollectorInformations(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.collectorCallerName);
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element date.");
         }
         output.writeInt(this.date);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AdditionalTaxCollectorInformations(input);
      }
      
      public function deserializeAs_AdditionalTaxCollectorInformations(input:ICustomDataInput) : void
      {
         this._collectorCallerNameFunc(input);
         this._dateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AdditionalTaxCollectorInformations(tree);
      }
      
      public function deserializeAsyncAs_AdditionalTaxCollectorInformations(tree:FuncTree) : void
      {
         tree.addChild(this._collectorCallerNameFunc);
         tree.addChild(this._dateFunc);
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
            throw new Error("Forbidden value (" + this.date + ") on element of AdditionalTaxCollectorInformations.date.");
         }
      }
   }
}
