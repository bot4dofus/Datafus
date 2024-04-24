package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.dofus.network.types.game.rank.RankMinimalInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class RankPublicInformation extends RankMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1722;
       
      
      public var order:uint = 0;
      
      public var gfxId:uint = 0;
      
      public function RankPublicInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1722;
      }
      
      public function initRankPublicInformation(id:uint = 0, name:String = "", order:uint = 0, gfxId:uint = 0) : RankPublicInformation
      {
         super.initRankMinimalInformation(id,name);
         this.order = order;
         this.gfxId = gfxId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.order = 0;
         this.gfxId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_RankPublicInformation(output);
      }
      
      public function serializeAs_RankPublicInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_RankMinimalInformation(output);
         if(this.order < 0)
         {
            throw new Error("Forbidden value (" + this.order + ") on element order.");
         }
         output.writeVarInt(this.order);
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element gfxId.");
         }
         output.writeVarInt(this.gfxId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RankPublicInformation(input);
      }
      
      public function deserializeAs_RankPublicInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._orderFunc(input);
         this._gfxIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RankPublicInformation(tree);
      }
      
      public function deserializeAsyncAs_RankPublicInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._orderFunc);
         tree.addChild(this._gfxIdFunc);
      }
      
      private function _orderFunc(input:ICustomDataInput) : void
      {
         this.order = input.readVarUhInt();
         if(this.order < 0)
         {
            throw new Error("Forbidden value (" + this.order + ") on element of RankPublicInformation.order.");
         }
      }
      
      private function _gfxIdFunc(input:ICustomDataInput) : void
      {
         this.gfxId = input.readVarUhInt();
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element of RankPublicInformation.gfxId.");
         }
      }
   }
}
