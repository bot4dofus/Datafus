package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.network.enums.ExchangeErrorEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class ExchangeApi implements IApi
   {
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function ExchangeApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(ExchangeApi));
         super();
      }
      
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getExchangeError(typeError:int) : String
      {
         switch(typeError)
         {
            case ExchangeErrorEnum.BID_SEARCH_ERROR:
               return "Erreur lors d\'une recherche dans l\'hotel de vente";
            case ExchangeErrorEnum.BUY_ERROR:
               return "Erreur lors d\'un achat";
            case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
               return "La requête d\'échange ne peut pas aboutir car l\'objet permetant de faire le craft n\'est pas équipé";
            case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
               return "La requête d\'échange ne peut pas aboutir, le joueur n est pas enregistré";
            case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
               return "La requête d\'échange ne peut pas aboutir car la cible est occupée";
            case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
               return "La requête d\'échange ne peut pas aboutir, le joueur est \'overloaded?\'";
            case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
               return "La requête d\'échange ne peut pas aboutir, la machine est trop loin";
            case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
               return "La requête d\'échange ne peut pas aboutir";
            case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
               return "Erreur lors d\'une transaction avec une ferme";
            case ExchangeErrorEnum.SELL_ERROR:
               return "Erreur lors d\'une vente";
            default:
               return "Erreur d\'échange de type inconnue";
         }
      }
   }
}
