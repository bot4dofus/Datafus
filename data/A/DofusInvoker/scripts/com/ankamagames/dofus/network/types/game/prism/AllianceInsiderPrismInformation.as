package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceInsiderPrismInformation extends PrismInformation implements INetworkType
   {
      
      public static const protocolId:uint = 7229;
       
      
      public var moduleObject:ObjectItem;
      
      public var moduleType:int = -1;
      
      public var cristalObject:ObjectItem;
      
      public var cristalType:int = -1;
      
      public var cristalNumberLeft:uint = 0;
      
      private var _moduleObjecttree:FuncTree;
      
      private var _cristalObjecttree:FuncTree;
      
      public function AllianceInsiderPrismInformation()
      {
         this.moduleObject = new ObjectItem();
         this.cristalObject = new ObjectItem();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7229;
      }
      
      public function initAllianceInsiderPrismInformation(state:uint = 1, placementDate:uint = 0, nuggetsCount:uint = 0, durability:uint = 0, nextEvolutionDate:Number = 0, moduleObject:ObjectItem = null, moduleType:int = -1, cristalObject:ObjectItem = null, cristalType:int = -1, cristalNumberLeft:uint = 0) : AllianceInsiderPrismInformation
      {
         super.initPrismInformation(state,placementDate,nuggetsCount,durability,nextEvolutionDate);
         this.moduleObject = moduleObject;
         this.moduleType = moduleType;
         this.cristalObject = cristalObject;
         this.cristalType = cristalType;
         this.cristalNumberLeft = cristalNumberLeft;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.moduleObject = new ObjectItem();
         this.cristalObject = new ObjectItem();
         this.cristalNumberLeft = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceInsiderPrismInformation(output);
      }
      
      public function serializeAs_AllianceInsiderPrismInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_PrismInformation(output);
         this.moduleObject.serializeAs_ObjectItem(output);
         output.writeInt(this.moduleType);
         this.cristalObject.serializeAs_ObjectItem(output);
         output.writeInt(this.cristalType);
         if(this.cristalNumberLeft < 0)
         {
            throw new Error("Forbidden value (" + this.cristalNumberLeft + ") on element cristalNumberLeft.");
         }
         output.writeInt(this.cristalNumberLeft);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInsiderPrismInformation(input);
      }
      
      public function deserializeAs_AllianceInsiderPrismInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.moduleObject = new ObjectItem();
         this.moduleObject.deserialize(input);
         this._moduleTypeFunc(input);
         this.cristalObject = new ObjectItem();
         this.cristalObject.deserialize(input);
         this._cristalTypeFunc(input);
         this._cristalNumberLeftFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInsiderPrismInformation(tree);
      }
      
      public function deserializeAsyncAs_AllianceInsiderPrismInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._moduleObjecttree = tree.addChild(this._moduleObjecttreeFunc);
         tree.addChild(this._moduleTypeFunc);
         this._cristalObjecttree = tree.addChild(this._cristalObjecttreeFunc);
         tree.addChild(this._cristalTypeFunc);
         tree.addChild(this._cristalNumberLeftFunc);
      }
      
      private function _moduleObjecttreeFunc(input:ICustomDataInput) : void
      {
         this.moduleObject = new ObjectItem();
         this.moduleObject.deserializeAsync(this._moduleObjecttree);
      }
      
      private function _moduleTypeFunc(input:ICustomDataInput) : void
      {
         this.moduleType = input.readInt();
      }
      
      private function _cristalObjecttreeFunc(input:ICustomDataInput) : void
      {
         this.cristalObject = new ObjectItem();
         this.cristalObject.deserializeAsync(this._cristalObjecttree);
      }
      
      private function _cristalTypeFunc(input:ICustomDataInput) : void
      {
         this.cristalType = input.readInt();
      }
      
      private function _cristalNumberLeftFunc(input:ICustomDataInput) : void
      {
         this.cristalNumberLeft = input.readInt();
         if(this.cristalNumberLeft < 0)
         {
            throw new Error("Forbidden value (" + this.cristalNumberLeft + ") on element of AllianceInsiderPrismInformation.cristalNumberLeft.");
         }
      }
   }
}
