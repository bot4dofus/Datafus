package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockGuildedInformations extends PaddockBuyableInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2305;
       
      
      public var deserted:Boolean = false;
      
      public var guildInfo:GuildInformations;
      
      private var _guildInfotree:FuncTree;
      
      public function PaddockGuildedInformations()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2305;
      }
      
      public function initPaddockGuildedInformations(price:Number = 0, locked:Boolean = false, deserted:Boolean = false, guildInfo:GuildInformations = null) : PaddockGuildedInformations
      {
         super.initPaddockBuyableInformations(price,locked);
         this.deserted = deserted;
         this.guildInfo = guildInfo;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.deserted = false;
         this.guildInfo = new GuildInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockGuildedInformations(output);
      }
      
      public function serializeAs_PaddockGuildedInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaddockBuyableInformations(output);
         output.writeBoolean(this.deserted);
         this.guildInfo.serializeAs_GuildInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockGuildedInformations(input);
      }
      
      public function deserializeAs_PaddockGuildedInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._desertedFunc(input);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockGuildedInformations(tree);
      }
      
      public function deserializeAsyncAs_PaddockGuildedInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._desertedFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
      }
      
      private function _desertedFunc(input:ICustomDataInput) : void
      {
         this.deserted = input.readBoolean();
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
   }
}
