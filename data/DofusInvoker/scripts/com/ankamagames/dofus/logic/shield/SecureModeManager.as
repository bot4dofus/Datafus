package com.ankamagames.dofus.logic.shield
{
   import by.blooddy.crypto.MD5;
   import com.ankama.haapi.client.api.ShieldApi;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.GameID;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.dofus.network.types.secure.TrustCertificate;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.system.Capabilities;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class SecureModeManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureModeManager));
      
      private static var _self:SecureModeManager;
       
      
      [Api(name="ShieldApi")]
      public var shieldApi:ShieldApi;
      
      private var _active:Boolean;
      
      private var _hasV1Certif:Boolean;
      
      private var _validateCodeCallback:Function;
      
      public var shieldLevel:uint;
      
      public function SecureModeManager()
      {
         this.shieldLevel = StoreDataManager.getInstance().getSetData(Constants.DATASTORE_COMPUTER_OPTIONS,"shieldLevel",ShieldSecureLevel.MEDIUM);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         HaapiKeyManager.getInstance().callWithApiKey(function(apiKey:String):void
         {
            var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),apiKey);
            shieldApi = new ShieldApi(apiCredentials);
         });
      }
      
      public static function getInstance() : SecureModeManager
      {
         if(!_self)
         {
            _self = new SecureModeManager();
         }
         return _self;
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set active(b:Boolean) : void
      {
         _log.debug("SECURE MODE IS ACTIVE : " + b);
         this._active = b;
         KernelEventsManager.getInstance().processCallback(HookList.SecureModeChange,b);
      }
      
      public function get certificate() : TrustCertificate
      {
         return this.retreiveCertificate();
      }
      
      public function askCode() : void
      {
         HaapiKeyManager.getInstance().callWithApiKey(function(apiKey:String):void
         {
            shieldApi = new ShieldApi(new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),apiKey));
            shieldApi.security_code().call();
         });
      }
      
      public function sendCode(code:String, callback:Function, errorCallback:Function, computerName:String) : void
      {
         HaapiKeyManager.getInstance().callWithApiKey(function(apiKey:String):void
         {
            var fooCertif:ShieldCertifcate = new ShieldCertifcate();
            fooCertif.secureLevel = shieldLevel;
            _validateCodeCallback = callback;
            shieldApi.validate_code(GameID.current,code.toUpperCase(),fooCertif.hash,fooCertif.reverseHash,!!computerName ? computerName : null).onSuccess(onValidateCodeSuccess).onError(errorCallback).call();
         });
      }
      
      private function getUsername() : String
      {
         return AuthentificationManager.getInstance().username.toLowerCase().split("|")[0];
      }
      
      private function getCertifFolder(version:uint, useCustomSharedObjectFolder:Boolean = false, useMacApplicationDirectory:Boolean = false) : File
      {
         var f:File = null;
         var parentDir:String = null;
         var tmp:Array = null;
         if(!useCustomSharedObjectFolder)
         {
            if(SystemManager.getSingleton().os == OperatingSystem.MAC_OS && useMacApplicationDirectory)
            {
               parentDir = File.userDirectory.resolvePath("Library/Preferences").nativePath;
            }
            else
            {
               tmp = File.applicationStorageDirectory.nativePath.split(File.separator);
               tmp.pop();
               tmp.pop();
               parentDir = tmp.join(File.separator);
            }
         }
         else
         {
            parentDir = CustomSharedObject.getCustomSharedObjectDirectory();
         }
         if(version == 1)
         {
            f = new File(parentDir + File.separator + "AnkamaCertificates/");
         }
         if(version == 2)
         {
            f = new File(parentDir + File.separator + "AnkamaCertificates/v2-RELEASE");
         }
         f.createDirectory();
         return f;
      }
      
      private function addCertificate(id:uint, content:String) : Boolean
      {
         var cert:ShieldCertifcate = null;
         var f:File = null;
         var fs:FileStream = null;
         _log.debug("ADD CERTIFICATE");
         cert = new ShieldCertifcate();
         cert.id = id;
         cert.content = content;
         cert.secureLevel = ShieldSecureLevel.MEDIUM;
         try
         {
            _log.debug("ADD CERTIFICATE :: TRY");
            f = this.getCertifFolder(2);
            f = f.resolvePath(MD5.hash(this.getUsername()));
            fs = new FileStream();
            fs.open(f,FileMode.WRITE);
            fs.writeBytes(cert.serialize());
            fs.close();
            return true;
         }
         catch(e:Error)
         {
            try
            {
               _log.debug("ADD CERTIFICATE :: FALLBACK");
               f = getCertifFolder(2,true);
               f = f.resolvePath(MD5.hash(getUsername()));
               fs = new FileStream();
               fs.open(f,FileMode.WRITE);
               fs.writeBytes(cert.serialize());
               fs.close();
               return true;
            }
            catch(e:Error)
            {
               _log.debug("ADD CERTIFICATE :: ERROR");
               ErrorManager.addError("Error writing certificate file at " + f.nativePath,e);
               return false;
            }
         }
      }
      
      public function checkMigrate() : void
      {
         if(!this._hasV1Certif)
         {
            return;
         }
         var certif:TrustCertificate = this.retreiveCertificate();
         this.migrate(certif.id,certif.hash);
      }
      
      private function getCertificateFile() : File
      {
         var found:Boolean = false;
         var userName:String = null;
         var fileName:String = null;
         var f:File = null;
         try
         {
            found = false;
            userName = this.getUsername();
            fileName = MD5.hash(userName);
            f = this.getCertifFolder(2).resolvePath(fileName);
            if(!f.exists)
            {
               f = this.getCertifFolder(2,false,true).resolvePath(fileName);
            }
            else
            {
               found = true;
               _log.debug("CERTIF FOUND IN V2-RELEASE : " + f.nativePath);
            }
            if(!found)
            {
               if(!f.exists)
               {
                  f = this.getCertifFolder(1).resolvePath(fileName);
               }
               else
               {
                  found = true;
                  _log.debug("CERTIF FOUND IN MAC APPLICATION DIRECTORY" + f.nativePath);
               }
            }
            if(!found)
            {
               if(!f.exists)
               {
                  f = this.getCertifFolder(1,false,true).resolvePath(fileName);
               }
               else
               {
                  found = true;
                  _log.debug("CERTIF FOUND IN V1" + f.nativePath);
               }
            }
            if(!found)
            {
               if(!f.exists)
               {
                  f = this.getCertifFolder(2,true).resolvePath(fileName);
               }
               else
               {
                  found = true;
                  _log.debug("CERTIF FOUND IN V1 ON MAC" + f.nativePath);
               }
            }
            if(!found)
            {
               if(!f.exists)
               {
                  f = this.getCertifFolder(1,true).resolvePath(fileName);
               }
               else
               {
                  found = true;
                  _log.debug("CERTIF FOUND IN CUSTOM SHARED OBJECTS V2" + f.nativePath);
               }
            }
            if(!found && f.exists)
            {
               found = true;
               _log.debug("CERTIF FOUND IN CUSTOM SHARED OBJECTS V1" + f.nativePath);
            }
            if(!found)
            {
               _log.debug("CERTIF NOT FOUND");
            }
            if(f.exists)
            {
               return f;
            }
         }
         catch(e:Error)
         {
            _log.error("Erreur lors de la recherche du certifcat : " + e.message);
         }
         return null;
      }
      
      public function retreiveCertificate() : TrustCertificate
      {
         var f:File = null;
         var fs:FileStream = null;
         var certif:ShieldCertifcate = null;
         _log.debug("TRY TO RETREIVE CERTIFICATE");
         try
         {
            this._hasV1Certif = false;
            f = this.getCertificateFile();
            if(f)
            {
               fs = new FileStream();
               fs.open(f,FileMode.READ);
               certif = ShieldCertifcate.fromRaw(fs);
               fs.close();
               if(certif.id == 0)
               {
                  _log.error("Certificat invalide (id=0)");
                  return null;
               }
               if(certif.version < 4 && (Capabilities.os == "Windows 10" || Capabilities.os.indexOf("Mac OS") != -1))
               {
                  this._hasV1Certif = true;
               }
               _log.debug("RETREIVE CERTIFICATE :: RETRIEVED");
               return certif.toNetwork();
            }
         }
         catch(e:Error)
         {
            _log.debug("RETREIVE CERTIFICATE :: ERROR " + e);
            ErrorManager.addError("Impossible de lire le fichier de certificat.",e);
         }
         return null;
      }
      
      private function migrate(iCertificateId:uint, oldCertif:String) : void
      {
         HaapiKeyManager.getInstance().callWithApiKey(function(apiKey:String):void
         {
            var fooCertif:ShieldCertifcate = new ShieldCertifcate();
            fooCertif.secureLevel = shieldLevel;
            shieldApi.migrate(apiKey,GameID.current,4,iCertificateId,oldCertif,fooCertif.hash,fooCertif.reverseHash).onSuccess(migrationSuccess).call();
         });
      }
      
      private function migrationSuccess(result:Object) : void
      {
         _log.debug("MIGRATION SUCCESS");
         this.addCertificate(result.id,result.certificate);
      }
      
      private function onValidateCodeSuccess(e:ApiClientEvent) : void
      {
         if(e.response.payload.id && e.response.payload.encodedCertificate)
         {
            this.addCertificate(e.response.payload.id,e.response.payload.encodedCertificate);
         }
         this._validateCodeCallback();
      }
   }
}
