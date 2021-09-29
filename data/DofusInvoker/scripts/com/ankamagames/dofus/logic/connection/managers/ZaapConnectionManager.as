package com.ankamagames.dofus.logic.connection.managers
{
   import com.ankama.zaap.ErrorCode;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.zaap.IZaapMessageHandler;
   import com.ankamagames.dofus.kernel.zaap.ZaapApi;
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.ZaapAuthenticationErrorEnum;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ApiTokenMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapUserInfosMessage;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import flash.utils.getQualifiedClassName;
   
   public class ZaapConnectionManager implements IZaapMessageHandler
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ZaapConnectionManager));
      
      private static const instance:ZaapConnectionManager = new ZaapConnectionManager();
       
      
      private var _api:ZaapApi;
      
      public function ZaapConnectionManager()
      {
         super();
         if(!this._api)
         {
            this._api = new ZaapApi(this);
         }
      }
      
      public static function getInstance() : ZaapConnectionManager
      {
         return instance;
      }
      
      public function requestApiToken() : void
      {
         if(ZaapApi.canLoginWithZaap())
         {
            this._api.getUserInfos();
         }
         else
         {
            this._api.getIdentificationToken();
         }
         KernelEventsManager.getInstance().processCallback(HookList.ConnectionTimerStart);
      }
      
      public function handleMessage(msg:IZaapInputMessage) : void
      {
         var zuim:ZaapUserInfosMessage = null;
         var atm:ApiTokenMessage = null;
         var lva:LoginValidationAction = null;
         var connectType:int = 0;
         _log.info("Received : " + getQualifiedClassName(msg));
         switch(true)
         {
            case msg is ZaapUserInfosMessage:
               zuim = msg as ZaapUserInfosMessage;
               if(zuim.login != null)
               {
                  AuthentificationManager.getInstance().username = zuim.login;
               }
               else
               {
                  _log.error("Error getting user infos from Zaap : " + ErrorCode.VALUES_TO_NAMES[zuim.error]);
               }
               this._api.getIdentificationToken();
               break;
            case msg is ApiTokenMessage:
               atm = msg as ApiTokenMessage;
               if(atm.getToken() != null)
               {
                  lva = AuthentificationManager.getInstance().loginValidationAction;
                  if(lva != null)
                  {
                     Kernel.getWorker().process(LoginValidationWithTicketAction.create(AuthentificationManager.getInstance().username,atm.getToken(),lva.autoSelectServer,lva.serverId,lva.host));
                  }
                  else
                  {
                     connectType = OptionManager.getOptionManager("dofus").getOption("autoConnectType");
                     if(connectType == 2)
                     {
                        PlayerManager.getInstance().allowAutoConnectCharacter = true;
                        PlayerManager.getInstance().autoConnectOfASpecificCharacterId = -1;
                     }
                     Kernel.getWorker().process(LoginValidationWithTicketAction.create(AuthentificationManager.getInstance().username,atm.getToken(),connectType != 0));
                  }
               }
               else if(ZaapApi.isUsingZaapLogin())
               {
                  _log.error("Error getting token from Zaap : " + ErrorCode.VALUES_TO_NAMES[atm.error]);
               }
               else
               {
                  switch(atm.error)
                  {
                     case ZaapAuthenticationErrorEnum.AUTHENTICATION_FAILED:
                        _log.error("Echec de l\'authentification");
                        break;
                     case ZaapAuthenticationErrorEnum.AUTHENTICATION_DECLINED:
                        _log.error("Authentification Décliné");
                        break;
                     case ZaapAuthenticationErrorEnum.AUTHENTICATION_REQUIRED:
                        _log.error("Vous devez ètres authentifié pour vous authentifié Oo");
                        break;
                     case ZaapAuthenticationErrorEnum.ACCOUNT_BANNED:
                        _log.error("Votre compte à été banni");
                        break;
                     case ZaapAuthenticationErrorEnum.ACCOUNT_LOCKED:
                        _log.error("Votre compte à été vérouillé");
                        break;
                     case ZaapAuthenticationErrorEnum.ACCOUNT_DELETED:
                        _log.error("Ce compte à été supprimé");
                        break;
                     case ZaapAuthenticationErrorEnum.IP_BLACKLISTED:
                        _log.error("Votre Ip à été bannis");
                        break;
                     case ZaapAuthenticationErrorEnum.SERVER_UNREACHABLE:
                        _log.error("Impossilve de joindre les serveur d\'authentification");
                        break;
                     default:
                        _log.error("Le service d\'authentification a rencontré un erreur inatendu");
                  }
               }
         }
      }
      
      public function handleConnectionOpened() : void
      {
      }
      
      public function handleConnectionClosed() : void
      {
      }
   }
}
