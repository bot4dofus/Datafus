package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockInstancesInformations extends PaddockInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4571;
       
      
      public var paddocks:Vector.<PaddockBuyableInformations>;
      
      private var _paddockstree:FuncTree;
      
      public function PaddockInstancesInformations()
      {
         this.paddocks = new Vector.<PaddockBuyableInformations>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4571;
      }
      
      public function initPaddockInstancesInformations(maxOutdoorMount:uint = 0, maxItems:uint = 0, paddocks:Vector.<PaddockBuyableInformations> = null) : PaddockInstancesInformations
      {
         super.initPaddockInformations(maxOutdoorMount,maxItems);
         this.paddocks = paddocks;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.paddocks = new Vector.<PaddockBuyableInformations>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockInstancesInformations(output);
      }
      
      public function serializeAs_PaddockInstancesInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaddockInformations(output);
         output.writeShort(this.paddocks.length);
         for(var _i1:uint = 0; _i1 < this.paddocks.length; _i1++)
         {
            output.writeShort((this.paddocks[_i1] as PaddockBuyableInformations).getTypeId());
            (this.paddocks[_i1] as PaddockBuyableInformations).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockInstancesInformations(input);
      }
      
      public function deserializeAs_PaddockInstancesInformations(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:PaddockBuyableInformations = null;
         super.deserialize(input);
         var _paddocksLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _paddocksLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(PaddockBuyableInformations,_id1);
            _item1.deserialize(input);
            this.paddocks.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockInstancesInformations(tree);
      }
      
      public function deserializeAsyncAs_PaddockInstancesInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._paddockstree = tree.addChild(this._paddockstreeFunc);
      }
      
      private function _paddockstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._paddockstree.addChild(this._paddocksFunc);
         }
      }
      
      private function _paddocksFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:PaddockBuyableInformations = ProtocolTypeManager.getInstance(PaddockBuyableInformations,_id);
         _item.deserialize(input);
         this.paddocks.push(_item);
      }
   }
}
