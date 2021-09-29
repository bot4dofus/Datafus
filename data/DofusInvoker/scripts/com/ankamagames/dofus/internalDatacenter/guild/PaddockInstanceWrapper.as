package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.network.types.game.paddock.PaddockBuyableInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockGuildedInformations;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   
   public class PaddockInstanceWrapper implements IDataCenter
   {
       
      
      public var price:Number = 0;
      
      public var guildIdentity:GuildWrapper;
      
      public var isSaleLocked:Boolean;
      
      public var isAbandonned:Boolean;
      
      private var _priceString:String;
      
      private var _guildNameForSorting:String = "~";
      
      public function PaddockInstanceWrapper()
      {
         super();
      }
      
      public static function create(paddockInstanceInfo:PaddockBuyableInformations) : PaddockInstanceWrapper
      {
         var pgi:PaddockGuildedInformations = null;
         var paddock:PaddockInstanceWrapper = new PaddockInstanceWrapper();
         paddock.price = paddockInstanceInfo.price;
         paddock.isSaleLocked = paddockInstanceInfo.locked;
         if(paddockInstanceInfo is PaddockGuildedInformations)
         {
            pgi = paddockInstanceInfo as PaddockGuildedInformations;
            paddock.isAbandonned = pgi.deserted;
            paddock.guildIdentity = GuildWrapper.create(pgi.guildInfo.guildId,pgi.guildInfo.guildName,pgi.guildInfo.guildEmblem,0);
         }
         return paddock;
      }
      
      public function get priceString() : String
      {
         if(!this._priceString)
         {
            this._priceString = StringUtils.kamasToString(this.price);
         }
         return this._priceString;
      }
      
      public function get guildNameForSorting() : String
      {
         if(this._guildNameForSorting == "~" && this.guildIdentity)
         {
            this._guildNameForSorting = this.guildIdentity.guildName;
         }
         return this._guildNameForSorting;
      }
   }
}
