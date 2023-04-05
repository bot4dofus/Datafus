package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildRankPublicInformation extends GuildRankMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8341;
       
      
      public var order:uint = 0;
      
      public var gfxId:uint = 0;
      
      public function GuildRankPublicInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8341;
      }
      
      public function initGuildRankPublicInformation(id:uint = 0, name:String = "", order:uint = 0, gfxId:uint = 0) : GuildRankPublicInformation
      {
         super.initGuildRankMinimalInformation(id,name);
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
         this.serializeAs_GuildRankPublicInformation(output);
      }
      
      public function serializeAs_GuildRankPublicInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildRankMinimalInformation(output);
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
         this.deserializeAs_GuildRankPublicInformation(input);
      }
      
      public function deserializeAs_GuildRankPublicInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._orderFunc(input);
         this._gfxIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildRankPublicInformation(tree);
      }
      
      public function deserializeAsyncAs_GuildRankPublicInformation(tree:FuncTree) : void
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
            throw new Error("Forbidden value (" + this.order + ") on element of GuildRankPublicInformation.order.");
         }
      }
      
      private function _gfxIdFunc(input:ICustomDataInput) : void
      {
         this.gfxId = input.readVarUhInt();
         if(this.gfxId < 0)
         {
            throw new Error("Forbidden value (" + this.gfxId + ") on element of GuildRankPublicInformation.gfxId.");
         }
      }
   }
}
