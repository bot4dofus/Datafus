package com.ankama.zaap
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class ZaapServiceImpl implements ZaapService
   {
       
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function ZaapServiceImpl(param1:TProtocol, param2:TProtocol = null)
      {
         super();
         this.iprot_ = param1;
         if(param2 == null)
         {
            this.oprot_ = param1;
         }
         else
         {
            this.oprot_ = param2;
         }
      }
      
      public function getInputProtocol() : TProtocol
      {
         return this.iprot_;
      }
      
      public function getOutputProtocol() : TProtocol
      {
         return this.oprot_;
      }
      
      public function connect(param1:String, param2:String, param3:int, param4:String, param5:Function, param6:Function) : void
      {
         var gameName:String = param1;
         var releaseName:String = param2;
         var instanceId:int = param3;
         var hash:String = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("connect",TMessageType.CALL,this.seqid_));
         var args:connect_args = new connect_args();
         args.gameName = gameName;
         args.releaseName = releaseName;
         args.instanceId = instanceId;
         args.hash = hash;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:connect_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new connect_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"connect failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function auth_getGameToken(param1:String, param2:int, param3:Function, param4:Function) : void
      {
         var gameSession:String = param1;
         var gameId:int = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("auth_getGameToken",TMessageType.CALL,this.seqid_));
         var args:auth_getGameToken_args = new auth_getGameToken_args();
         args.gameSession = gameSession;
         args.gameId = gameId;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:auth_getGameToken_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new auth_getGameToken_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"auth_getGameToken failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function updater_isUpdateAvailable(param1:String, param2:Function, param3:Function) : void
      {
         var gameSession:String = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("updater_isUpdateAvailable",TMessageType.CALL,this.seqid_));
         var args:updater_isUpdateAvailable_args = new updater_isUpdateAvailable_args();
         args.gameSession = gameSession;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:updater_isUpdateAvailable_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new updater_isUpdateAvailable_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"updater_isUpdateAvailable failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function settings_get(param1:String, param2:String, param3:Function, param4:Function) : void
      {
         var gameSession:String = param1;
         var key:String = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("settings_get",TMessageType.CALL,this.seqid_));
         var args:settings_get_args = new settings_get_args();
         args.gameSession = gameSession;
         args.key = key;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:settings_get_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new settings_get_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"settings_get failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function settings_set(param1:String, param2:String, param3:String, param4:Function, param5:Function) : void
      {
         var gameSession:String = param1;
         var key:String = param2;
         var value:String = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("settings_set",TMessageType.CALL,this.seqid_));
         var args:settings_set_args = new settings_set_args();
         args.gameSession = gameSession;
         args.key = key;
         args.value = value;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:settings_set_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new settings_set_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onSuccess != null)
               {
                  onSuccess();
               }
               return;
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
               return;
            }
         });
      }
      
      public function userInfo_get(param1:String, param2:Function, param3:Function) : void
      {
         var gameSession:String = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("userInfo_get",TMessageType.CALL,this.seqid_));
         var args:userInfo_get_args = new userInfo_get_args();
         args.gameSession = gameSession;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:userInfo_get_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new userInfo_get_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"userInfo_get failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function release_restartOnExit(param1:String, param2:Function, param3:Function) : void
      {
         var gameSession:String = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("release_restartOnExit",TMessageType.CALL,this.seqid_));
         var args:release_restartOnExit_args = new release_restartOnExit_args();
         args.gameSession = gameSession;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:release_restartOnExit_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new release_restartOnExit_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(onSuccess != null)
               {
                  onSuccess();
               }
               return;
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
               return;
            }
         });
      }
      
      public function release_exitAndRepair(param1:String, param2:Boolean, param3:Function, param4:Function) : void
      {
         var gameSession:String = param1;
         var restartAfterRepair:Boolean = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("release_exitAndRepair",TMessageType.CALL,this.seqid_));
         var args:release_exitAndRepair_args = new release_exitAndRepair_args();
         args.gameSession = gameSession;
         args.restartAfterRepair = restartAfterRepair;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:release_exitAndRepair_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new release_exitAndRepair_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(onSuccess != null)
               {
                  onSuccess();
               }
               return;
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
               return;
            }
         });
      }
      
      public function zaapVersion_get(param1:String, param2:Function, param3:Function) : void
      {
         var gameSession:String = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("zaapVersion_get",TMessageType.CALL,this.seqid_));
         var args:zaapVersion_get_args = new zaapVersion_get_args();
         args.gameSession = gameSession;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:zaapVersion_get_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new zaapVersion_get_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"zaapVersion_get failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function zaapMustUpdate_get(param1:String, param2:Function, param3:Function) : void
      {
         var gameSession:String = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("zaapMustUpdate_get",TMessageType.CALL,this.seqid_));
         var args:zaapMustUpdate_get_args = new zaapMustUpdate_get_args();
         args.gameSession = gameSession;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:zaapMustUpdate_get_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new zaapMustUpdate_get_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"zaapMustUpdate_get failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function payArticle(param1:String, param2:String, param3:int, param4:OverlayPosition, param5:Function, param6:Function) : void
      {
         var gameSession:String = param1;
         var shopApiKey:String = param2;
         var articleId:int = param3;
         var pos:OverlayPosition = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("payArticle",TMessageType.CALL,this.seqid_));
         var args:payArticle_args = new payArticle_args();
         args.gameSession = gameSession;
         args.shopApiKey = shopApiKey;
         args.articleId = articleId;
         args.pos = pos;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:payArticle_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new payArticle_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"payArticle failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function openOverlay(param1:String, param2:String, param3:OverlayPosition, param4:Function, param5:Function) : void
      {
         var gameSession:String = param1;
         var url:String = param2;
         var pos:OverlayPosition = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("openOverlay",TMessageType.CALL,this.seqid_));
         var args:openOverlay_args = new openOverlay_args();
         args.gameSession = gameSession;
         args.url = url;
         args.pos = pos;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:openOverlay_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new openOverlay_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"openOverlay failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function auth_getGameTokenWithWindowId(param1:String, param2:int, param3:int, param4:Function, param5:Function) : void
      {
         var gameSession:String = param1;
         var gameId:int = param2;
         var windowId:int = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("auth_getGameTokenWithWindowId",TMessageType.CALL,this.seqid_));
         var args:auth_getGameTokenWithWindowId_args = new auth_getGameTokenWithWindowId_args();
         args.gameSession = gameSession;
         args.gameId = gameId;
         args.windowId = windowId;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:auth_getGameTokenWithWindowId_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new auth_getGameTokenWithWindowId_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(result.error != null)
               {
                  if(onError != null)
                  {
                     onError(result.error);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"auth_getGameTokenWithWindowId failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class connect_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("connect_args");
   
   private static const GAME_NAME_FIELD_DESC:TField = new TField("gameName",TType.STRING,1);
   
   private static const RELEASE_NAME_FIELD_DESC:TField = new TField("releaseName",TType.STRING,2);
   
   private static const INSTANCE_ID_FIELD_DESC:TField = new TField("instanceId",TType.I32,3);
   
   private static const HASH_FIELD_DESC:TField = new TField("hash",TType.STRING,4);
   
   public static const GAMENAME:int = 1;
   
   public static const RELEASENAME:int = 2;
   
   public static const INSTANCEID:int = 3;
   
   public static const HASH:int = 4;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMENAME] = new FieldMetaData("gameName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[RELEASENAME] = new FieldMetaData("releaseName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[INSTANCEID] = new FieldMetaData("instanceId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[HASH] = new FieldMetaData("hash",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(connect_args,metaDataMap);
   }
   
   private var _gameName:String;
   
   private var _releaseName:String;
   
   private var _instanceId:int;
   
   private var _hash:String;
   
   private var __isset_instanceId:Boolean = false;
   
   function connect_args()
   {
      super();
   }
   
   public function get gameName() : String
   {
      return this._gameName;
   }
   
   public function set gameName(param1:String) : void
   {
      this._gameName = param1;
   }
   
   public function unsetGameName() : void
   {
      this.gameName = null;
   }
   
   public function isSetGameName() : Boolean
   {
      return this.gameName != null;
   }
   
   public function get releaseName() : String
   {
      return this._releaseName;
   }
   
   public function set releaseName(param1:String) : void
   {
      this._releaseName = param1;
   }
   
   public function unsetReleaseName() : void
   {
      this.releaseName = null;
   }
   
   public function isSetReleaseName() : Boolean
   {
      return this.releaseName != null;
   }
   
   public function get instanceId() : int
   {
      return this._instanceId;
   }
   
   public function set instanceId(param1:int) : void
   {
      this._instanceId = param1;
      this.__isset_instanceId = true;
   }
   
   public function unsetInstanceId() : void
   {
      this.__isset_instanceId = false;
   }
   
   public function isSetInstanceId() : Boolean
   {
      return this.__isset_instanceId;
   }
   
   public function get hash() : String
   {
      return this._hash;
   }
   
   public function set hash(param1:String) : void
   {
      this._hash = param1;
   }
   
   public function unsetHash() : void
   {
      this.hash = null;
   }
   
   public function isSetHash() : Boolean
   {
      return this.hash != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMENAME:
            if(param2 == null)
            {
               this.unsetGameName();
            }
            else
            {
               this.gameName = param2;
            }
            break;
         case RELEASENAME:
            if(param2 == null)
            {
               this.unsetReleaseName();
            }
            else
            {
               this.releaseName = param2;
            }
            break;
         case INSTANCEID:
            if(param2 == null)
            {
               this.unsetInstanceId();
            }
            else
            {
               this.instanceId = param2;
            }
            break;
         case HASH:
            if(param2 == null)
            {
               this.unsetHash();
            }
            else
            {
               this.hash = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMENAME:
            return this.gameName;
         case RELEASENAME:
            return this.releaseName;
         case INSTANCEID:
            return this.instanceId;
         case HASH:
            return this.hash;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMENAME:
            return this.isSetGameName();
         case RELEASENAME:
            return this.isSetReleaseName();
         case INSTANCEID:
            return this.isSetInstanceId();
         case HASH:
            return this.isSetHash();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMENAME:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameName = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case RELEASENAME:
               if(_loc2_.type == TType.STRING)
               {
                  this.releaseName = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case INSTANCEID:
               if(_loc2_.type == TType.I32)
               {
                  this.instanceId = param1.readI32();
                  this.__isset_instanceId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case HASH:
               if(_loc2_.type == TType.STRING)
               {
                  this.hash = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameName != null)
      {
         param1.writeFieldBegin(GAME_NAME_FIELD_DESC);
         param1.writeString(this.gameName);
         param1.writeFieldEnd();
      }
      if(this.releaseName != null)
      {
         param1.writeFieldBegin(RELEASE_NAME_FIELD_DESC);
         param1.writeString(this.releaseName);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(INSTANCE_ID_FIELD_DESC);
      param1.writeI32(this.instanceId);
      param1.writeFieldEnd();
      if(this.hash != null)
      {
         param1.writeFieldBegin(HASH_FIELD_DESC);
         param1.writeString(this.hash);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("connect_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameName:";
      if(this.gameName == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameName;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "releaseName:";
      if(this.releaseName == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.releaseName;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "instanceId:";
      _loc1_ += this.instanceId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "hash:";
      if(this.hash == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.hash;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class connect_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("connect_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(connect_result,metaDataMap);
   }
   
   private var _success:String;
   
   private var _error:ZaapError;
   
   function connect_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            break;
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      else if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("connect_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class auth_getGameToken_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("auth_getGameToken_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,2);
   
   public static const GAMESESSION:int = 1;
   
   public static const GAMEID:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(auth_getGameToken_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _gameId:int;
   
   private var __isset_gameId:Boolean = false;
   
   function auth_getGameToken_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get gameId() : int
   {
      return this._gameId;
   }
   
   public function set gameId(param1:int) : void
   {
      this._gameId = param1;
      this.__isset_gameId = true;
   }
   
   public function unsetGameId() : void
   {
      this.__isset_gameId = false;
   }
   
   public function isSetGameId() : Boolean
   {
      return this.__isset_gameId;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case GAMEID:
            if(param2 == null)
            {
               this.unsetGameId();
            }
            else
            {
               this.gameId = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case GAMEID:
            return this.gameId;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case GAMEID:
            return this.isSetGameId();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case GAMEID:
               if(_loc2_.type == TType.I32)
               {
                  this.gameId = param1.readI32();
                  this.__isset_gameId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(GAME_ID_FIELD_DESC);
      param1.writeI32(this.gameId);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("auth_getGameToken_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "gameId:";
      _loc1_ += this.gameId;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class auth_getGameToken_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("auth_getGameToken_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(auth_getGameToken_result,metaDataMap);
   }
   
   private var _success:String;
   
   private var _error:ZaapError;
   
   function auth_getGameToken_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            break;
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      else if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("auth_getGameToken_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class updater_isUpdateAvailable_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("updater_isUpdateAvailable_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   public static const GAMESESSION:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(updater_isUpdateAvailable_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   function updater_isUpdateAvailable_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("updater_isUpdateAvailable_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class updater_isUpdateAvailable_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("updater_isUpdateAvailable_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.BOOL,0);
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.BOOL));
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(updater_isUpdateAvailable_result,metaDataMap);
   }
   
   private var _success:Boolean;
   
   private var _error:ZaapError;
   
   private var __isset_success:Boolean = false;
   
   function updater_isUpdateAvailable_result()
   {
      super();
   }
   
   public function get success() : Boolean
   {
      return this._success;
   }
   
   public function set success(param1:Boolean) : void
   {
      this._success = param1;
      this.__isset_success = true;
   }
   
   public function unsetSuccess() : void
   {
      this.__isset_success = false;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.__isset_success;
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            break;
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.BOOL)
               {
                  this.success = param1.readBool();
                  this.__isset_success = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeBool(this.success);
         param1.writeFieldEnd();
      }
      else if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("updater_isUpdateAvailable_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      _loc1_ += this.success;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class settings_get_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("settings_get_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const KEY_FIELD_DESC:TField = new TField("key",TType.STRING,2);
   
   public static const GAMESESSION:int = 1;
   
   public static const KEY:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[KEY] = new FieldMetaData("key",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(settings_get_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _key:String;
   
   function settings_get_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get key() : String
   {
      return this._key;
   }
   
   public function set key(param1:String) : void
   {
      this._key = param1;
   }
   
   public function unsetKey() : void
   {
      this.key = null;
   }
   
   public function isSetKey() : Boolean
   {
      return this.key != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case KEY:
            if(param2 == null)
            {
               this.unsetKey();
            }
            else
            {
               this.key = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case KEY:
            return this.key;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case KEY:
            return this.isSetKey();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case KEY:
               if(_loc2_.type == TType.STRING)
               {
                  this.key = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      if(this.key != null)
      {
         param1.writeFieldBegin(KEY_FIELD_DESC);
         param1.writeString(this.key);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("settings_get_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "key:";
      if(this.key == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.key;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class settings_get_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("settings_get_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(settings_get_result,metaDataMap);
   }
   
   private var _success:String;
   
   private var _error:ZaapError;
   
   function settings_get_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            break;
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      else if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("settings_get_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class settings_set_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("settings_set_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const KEY_FIELD_DESC:TField = new TField("key",TType.STRING,2);
   
   private static const VALUE_FIELD_DESC:TField = new TField("value",TType.STRING,3);
   
   public static const GAMESESSION:int = 1;
   
   public static const KEY:int = 2;
   
   public static const VALUE:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[KEY] = new FieldMetaData("key",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[VALUE] = new FieldMetaData("value",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(settings_set_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _key:String;
   
   private var _value:String;
   
   function settings_set_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get key() : String
   {
      return this._key;
   }
   
   public function set key(param1:String) : void
   {
      this._key = param1;
   }
   
   public function unsetKey() : void
   {
      this.key = null;
   }
   
   public function isSetKey() : Boolean
   {
      return this.key != null;
   }
   
   public function get value() : String
   {
      return this._value;
   }
   
   public function set value(param1:String) : void
   {
      this._value = param1;
   }
   
   public function unsetValue() : void
   {
      this.value = null;
   }
   
   public function isSetValue() : Boolean
   {
      return this.value != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case KEY:
            if(param2 == null)
            {
               this.unsetKey();
            }
            else
            {
               this.key = param2;
            }
            break;
         case VALUE:
            if(param2 == null)
            {
               this.unsetValue();
            }
            else
            {
               this.value = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case KEY:
            return this.key;
         case VALUE:
            return this.value;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case KEY:
            return this.isSetKey();
         case VALUE:
            return this.isSetValue();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case KEY:
               if(_loc2_.type == TType.STRING)
               {
                  this.key = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case VALUE:
               if(_loc2_.type == TType.STRING)
               {
                  this.value = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      if(this.key != null)
      {
         param1.writeFieldBegin(KEY_FIELD_DESC);
         param1.writeString(this.key);
         param1.writeFieldEnd();
      }
      if(this.value != null)
      {
         param1.writeFieldBegin(VALUE_FIELD_DESC);
         param1.writeString(this.value);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("settings_set_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "key:";
      if(this.key == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.key;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "value:";
      if(this.value == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.value;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class settings_set_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("settings_set_result");
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(settings_set_result,metaDataMap);
   }
   
   private var _error:ZaapError;
   
   function settings_set_result()
   {
      super();
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("settings_set_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class userInfo_get_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("userInfo_get_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   public static const GAMESESSION:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(userInfo_get_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   function userInfo_get_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("userInfo_get_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class userInfo_get_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("userInfo_get_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(userInfo_get_result,metaDataMap);
   }
   
   private var _success:String;
   
   private var _error:ZaapError;
   
   function userInfo_get_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            break;
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      else if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("userInfo_get_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class release_restartOnExit_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("release_restartOnExit_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   public static const GAMESESSION:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(release_restartOnExit_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   function release_restartOnExit_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("release_restartOnExit_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class release_restartOnExit_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("release_restartOnExit_result");
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      FieldMetaData.addStructMetaDataMap(release_restartOnExit_result,metaDataMap);
   }
   
   function release_restartOnExit_result()
   {
      super();
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      var _loc3_:* = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function getFieldValue(param1:int) : *
   {
      var _loc2_:* = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function isSet(param1:int) : Boolean
   {
      var _loc2_:* = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         var _loc3_:* = _loc2_.id;
         switch(0)
         {
         }
         TProtocolUtil.skip(param1,_loc2_.type);
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("release_restartOnExit_result(");
      var _loc2_:Boolean = true;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class release_exitAndRepair_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("release_exitAndRepair_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const RESTART_AFTER_REPAIR_FIELD_DESC:TField = new TField("restartAfterRepair",TType.BOOL,2);
   
   public static const GAMESESSION:int = 1;
   
   public static const RESTARTAFTERREPAIR:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[RESTARTAFTERREPAIR] = new FieldMetaData("restartAfterRepair",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.BOOL));
      FieldMetaData.addStructMetaDataMap(release_exitAndRepair_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _restartAfterRepair:Boolean;
   
   private var __isset_restartAfterRepair:Boolean = false;
   
   function release_exitAndRepair_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get restartAfterRepair() : Boolean
   {
      return this._restartAfterRepair;
   }
   
   public function set restartAfterRepair(param1:Boolean) : void
   {
      this._restartAfterRepair = param1;
      this.__isset_restartAfterRepair = true;
   }
   
   public function unsetRestartAfterRepair() : void
   {
      this.__isset_restartAfterRepair = false;
   }
   
   public function isSetRestartAfterRepair() : Boolean
   {
      return this.__isset_restartAfterRepair;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case RESTARTAFTERREPAIR:
            if(param2 == null)
            {
               this.unsetRestartAfterRepair();
            }
            else
            {
               this.restartAfterRepair = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case RESTARTAFTERREPAIR:
            return this.restartAfterRepair;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case RESTARTAFTERREPAIR:
            return this.isSetRestartAfterRepair();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case RESTARTAFTERREPAIR:
               if(_loc2_.type == TType.BOOL)
               {
                  this.restartAfterRepair = param1.readBool();
                  this.__isset_restartAfterRepair = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(RESTART_AFTER_REPAIR_FIELD_DESC);
      param1.writeBool(this.restartAfterRepair);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("release_exitAndRepair_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "restartAfterRepair:";
      _loc1_ += this.restartAfterRepair;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class release_exitAndRepair_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("release_exitAndRepair_result");
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      FieldMetaData.addStructMetaDataMap(release_exitAndRepair_result,metaDataMap);
   }
   
   function release_exitAndRepair_result()
   {
      super();
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      var _loc3_:* = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function getFieldValue(param1:int) : *
   {
      var _loc2_:* = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function isSet(param1:int) : Boolean
   {
      var _loc2_:* = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         var _loc3_:* = _loc2_.id;
         switch(0)
         {
         }
         TProtocolUtil.skip(param1,_loc2_.type);
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("release_exitAndRepair_result(");
      var _loc2_:Boolean = true;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class zaapVersion_get_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("zaapVersion_get_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   public static const GAMESESSION:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(zaapVersion_get_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   function zaapVersion_get_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("zaapVersion_get_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class zaapVersion_get_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("zaapVersion_get_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(zaapVersion_get_result,metaDataMap);
   }
   
   private var _success:String;
   
   function zaapVersion_get_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("zaapVersion_get_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class zaapMustUpdate_get_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("zaapMustUpdate_get_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   public static const GAMESESSION:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(zaapMustUpdate_get_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   function zaapMustUpdate_get_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("zaapMustUpdate_get_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class zaapMustUpdate_get_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("zaapMustUpdate_get_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.BOOL,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.BOOL));
      FieldMetaData.addStructMetaDataMap(zaapMustUpdate_get_result,metaDataMap);
   }
   
   private var _success:Boolean;
   
   private var __isset_success:Boolean = false;
   
   function zaapMustUpdate_get_result()
   {
      super();
   }
   
   public function get success() : Boolean
   {
      return this._success;
   }
   
   public function set success(param1:Boolean) : void
   {
      this._success = param1;
      this.__isset_success = true;
   }
   
   public function unsetSuccess() : void
   {
      this.__isset_success = false;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.__isset_success;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.BOOL)
               {
                  this.success = param1.readBool();
                  this.__isset_success = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeBool(this.success);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("zaapMustUpdate_get_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      _loc1_ += this.success;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.OverlayPosition;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class payArticle_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("payArticle_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const SHOP_API_KEY_FIELD_DESC:TField = new TField("shopApiKey",TType.STRING,-1);
   
   private static const ARTICLE_ID_FIELD_DESC:TField = new TField("articleId",TType.I32,-2);
   
   private static const POS_FIELD_DESC:TField = new TField("pos",TType.STRUCT,-3);
   
   public static const GAMESESSION:int = 1;
   
   public static const SHOPAPIKEY:int = -1;
   
   public static const ARTICLEID:int = -2;
   
   public static const POS:int = -3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[SHOPAPIKEY] = new FieldMetaData("shopApiKey",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ARTICLEID] = new FieldMetaData("articleId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[POS] = new FieldMetaData("pos",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,OverlayPosition));
      FieldMetaData.addStructMetaDataMap(payArticle_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _shopApiKey:String;
   
   private var _articleId:int;
   
   private var _pos:OverlayPosition;
   
   private var __isset_articleId:Boolean = false;
   
   function payArticle_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get shopApiKey() : String
   {
      return this._shopApiKey;
   }
   
   public function set shopApiKey(param1:String) : void
   {
      this._shopApiKey = param1;
   }
   
   public function unsetShopApiKey() : void
   {
      this.shopApiKey = null;
   }
   
   public function isSetShopApiKey() : Boolean
   {
      return this.shopApiKey != null;
   }
   
   public function get articleId() : int
   {
      return this._articleId;
   }
   
   public function set articleId(param1:int) : void
   {
      this._articleId = param1;
      this.__isset_articleId = true;
   }
   
   public function unsetArticleId() : void
   {
      this.__isset_articleId = false;
   }
   
   public function isSetArticleId() : Boolean
   {
      return this.__isset_articleId;
   }
   
   public function get pos() : OverlayPosition
   {
      return this._pos;
   }
   
   public function set pos(param1:OverlayPosition) : void
   {
      this._pos = param1;
   }
   
   public function unsetPos() : void
   {
      this.pos = null;
   }
   
   public function isSetPos() : Boolean
   {
      return this.pos != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case SHOPAPIKEY:
            if(param2 == null)
            {
               this.unsetShopApiKey();
            }
            else
            {
               this.shopApiKey = param2;
            }
            break;
         case ARTICLEID:
            if(param2 == null)
            {
               this.unsetArticleId();
            }
            else
            {
               this.articleId = param2;
            }
            break;
         case POS:
            if(param2 == null)
            {
               this.unsetPos();
            }
            else
            {
               this.pos = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case SHOPAPIKEY:
            return this.shopApiKey;
         case ARTICLEID:
            return this.articleId;
         case POS:
            return this.pos;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case SHOPAPIKEY:
            return this.isSetShopApiKey();
         case ARTICLEID:
            return this.isSetArticleId();
         case POS:
            return this.isSetPos();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case SHOPAPIKEY:
               if(_loc2_.type == TType.STRING)
               {
                  this.shopApiKey = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ARTICLEID:
               if(_loc2_.type == TType.I32)
               {
                  this.articleId = param1.readI32();
                  this.__isset_articleId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case POS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.pos = new OverlayPosition();
                  this.pos.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.pos != null)
      {
         param1.writeFieldBegin(POS_FIELD_DESC);
         this.pos.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(ARTICLE_ID_FIELD_DESC);
      param1.writeI32(this.articleId);
      param1.writeFieldEnd();
      if(this.shopApiKey != null)
      {
         param1.writeFieldBegin(SHOP_API_KEY_FIELD_DESC);
         param1.writeString(this.shopApiKey);
         param1.writeFieldEnd();
      }
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("payArticle_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "shopApiKey:";
      if(this.shopApiKey == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.shopApiKey;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "articleId:";
      _loc1_ += this.articleId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "pos:";
      if(this.pos == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.pos;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class payArticle_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("payArticle_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.BOOL,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.BOOL));
      FieldMetaData.addStructMetaDataMap(payArticle_result,metaDataMap);
   }
   
   private var _success:Boolean;
   
   private var __isset_success:Boolean = false;
   
   function payArticle_result()
   {
      super();
   }
   
   public function get success() : Boolean
   {
      return this._success;
   }
   
   public function set success(param1:Boolean) : void
   {
      this._success = param1;
      this.__isset_success = true;
   }
   
   public function unsetSuccess() : void
   {
      this.__isset_success = false;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.__isset_success;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.BOOL)
               {
                  this.success = param1.readBool();
                  this.__isset_success = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeBool(this.success);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("payArticle_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      _loc1_ += this.success;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.OverlayPosition;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class openOverlay_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("openOverlay_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const URL_FIELD_DESC:TField = new TField("url",TType.STRING,-1);
   
   private static const POS_FIELD_DESC:TField = new TField("pos",TType.STRUCT,-2);
   
   public static const GAMESESSION:int = 1;
   
   public static const URL:int = -1;
   
   public static const POS:int = -2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[URL] = new FieldMetaData("url",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[POS] = new FieldMetaData("pos",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,OverlayPosition));
      FieldMetaData.addStructMetaDataMap(openOverlay_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _url:String;
   
   private var _pos:OverlayPosition;
   
   function openOverlay_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get url() : String
   {
      return this._url;
   }
   
   public function set url(param1:String) : void
   {
      this._url = param1;
   }
   
   public function unsetUrl() : void
   {
      this.url = null;
   }
   
   public function isSetUrl() : Boolean
   {
      return this.url != null;
   }
   
   public function get pos() : OverlayPosition
   {
      return this._pos;
   }
   
   public function set pos(param1:OverlayPosition) : void
   {
      this._pos = param1;
   }
   
   public function unsetPos() : void
   {
      this.pos = null;
   }
   
   public function isSetPos() : Boolean
   {
      return this.pos != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case URL:
            if(param2 == null)
            {
               this.unsetUrl();
            }
            else
            {
               this.url = param2;
            }
            break;
         case POS:
            if(param2 == null)
            {
               this.unsetPos();
            }
            else
            {
               this.pos = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case URL:
            return this.url;
         case POS:
            return this.pos;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case URL:
            return this.isSetUrl();
         case POS:
            return this.isSetPos();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case URL:
               if(_loc2_.type == TType.STRING)
               {
                  this.url = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case POS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.pos = new OverlayPosition();
                  this.pos.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.pos != null)
      {
         param1.writeFieldBegin(POS_FIELD_DESC);
         this.pos.write(param1);
         param1.writeFieldEnd();
      }
      if(this.url != null)
      {
         param1.writeFieldBegin(URL_FIELD_DESC);
         param1.writeString(this.url);
         param1.writeFieldEnd();
      }
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("openOverlay_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "url:";
      if(this.url == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.url;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "pos:";
      if(this.pos == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.pos;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class openOverlay_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("openOverlay_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.BOOL,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.BOOL));
      FieldMetaData.addStructMetaDataMap(openOverlay_result,metaDataMap);
   }
   
   private var _success:Boolean;
   
   private var __isset_success:Boolean = false;
   
   function openOverlay_result()
   {
      super();
   }
   
   public function get success() : Boolean
   {
      return this._success;
   }
   
   public function set success(param1:Boolean) : void
   {
      this._success = param1;
      this.__isset_success = true;
   }
   
   public function unsetSuccess() : void
   {
      this.__isset_success = false;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.__isset_success;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.BOOL)
               {
                  this.success = param1.readBool();
                  this.__isset_success = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeBool(this.success);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("openOverlay_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      _loc1_ += this.success;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class auth_getGameTokenWithWindowId_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("auth_getGameTokenWithWindowId_args");
   
   private static const GAME_SESSION_FIELD_DESC:TField = new TField("gameSession",TType.STRING,1);
   
   private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,2);
   
   private static const WINDOW_ID_FIELD_DESC:TField = new TField("windowId",TType.I32,3);
   
   public static const GAMESESSION:int = 1;
   
   public static const GAMEID:int = 2;
   
   public static const WINDOWID:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[GAMESESSION] = new FieldMetaData("gameSession",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[WINDOWID] = new FieldMetaData("windowId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(auth_getGameTokenWithWindowId_args,metaDataMap);
   }
   
   private var _gameSession:String;
   
   private var _gameId:int;
   
   private var _windowId:int;
   
   private var __isset_gameId:Boolean = false;
   
   private var __isset_windowId:Boolean = false;
   
   function auth_getGameTokenWithWindowId_args()
   {
      super();
   }
   
   public function get gameSession() : String
   {
      return this._gameSession;
   }
   
   public function set gameSession(param1:String) : void
   {
      this._gameSession = param1;
   }
   
   public function unsetGameSession() : void
   {
      this.gameSession = null;
   }
   
   public function isSetGameSession() : Boolean
   {
      return this.gameSession != null;
   }
   
   public function get gameId() : int
   {
      return this._gameId;
   }
   
   public function set gameId(param1:int) : void
   {
      this._gameId = param1;
      this.__isset_gameId = true;
   }
   
   public function unsetGameId() : void
   {
      this.__isset_gameId = false;
   }
   
   public function isSetGameId() : Boolean
   {
      return this.__isset_gameId;
   }
   
   public function get windowId() : int
   {
      return this._windowId;
   }
   
   public function set windowId(param1:int) : void
   {
      this._windowId = param1;
      this.__isset_windowId = true;
   }
   
   public function unsetWindowId() : void
   {
      this.__isset_windowId = false;
   }
   
   public function isSetWindowId() : Boolean
   {
      return this.__isset_windowId;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case GAMESESSION:
            if(param2 == null)
            {
               this.unsetGameSession();
            }
            else
            {
               this.gameSession = param2;
            }
            break;
         case GAMEID:
            if(param2 == null)
            {
               this.unsetGameId();
            }
            else
            {
               this.gameId = param2;
            }
            break;
         case WINDOWID:
            if(param2 == null)
            {
               this.unsetWindowId();
            }
            else
            {
               this.windowId = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.gameSession;
         case GAMEID:
            return this.gameId;
         case WINDOWID:
            return this.windowId;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case GAMESESSION:
            return this.isSetGameSession();
         case GAMEID:
            return this.isSetGameId();
         case WINDOWID:
            return this.isSetWindowId();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case GAMESESSION:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameSession = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case GAMEID:
               if(_loc2_.type == TType.I32)
               {
                  this.gameId = param1.readI32();
                  this.__isset_gameId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case WINDOWID:
               if(_loc2_.type == TType.I32)
               {
                  this.windowId = param1.readI32();
                  this.__isset_windowId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.gameSession != null)
      {
         param1.writeFieldBegin(GAME_SESSION_FIELD_DESC);
         param1.writeString(this.gameSession);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(GAME_ID_FIELD_DESC);
      param1.writeI32(this.gameId);
      param1.writeFieldEnd();
      param1.writeFieldBegin(WINDOW_ID_FIELD_DESC);
      param1.writeI32(this.windowId);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("auth_getGameTokenWithWindowId_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameSession:";
      if(this.gameSession == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameSession;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "gameId:";
      _loc1_ += this.gameId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "windowId:";
      _loc1_ += this.windowId;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

import com.ankama.zaap.ZaapError;
import flash.utils.Dictionary;
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class auth_getGameTokenWithWindowId_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("auth_getGameTokenWithWindowId_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   private static const ERROR_FIELD_DESC:TField = new TField("error",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERROR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   {
      metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ERROR] = new FieldMetaData("error",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ZaapError));
      FieldMetaData.addStructMetaDataMap(auth_getGameTokenWithWindowId_result,metaDataMap);
   }
   
   private var _success:String;
   
   private var _error:ZaapError;
   
   function auth_getGameTokenWithWindowId_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function get error() : ZaapError
   {
      return this._error;
   }
   
   public function set error(param1:ZaapError) : void
   {
      this._error = param1;
   }
   
   public function unsetError() : void
   {
      this.error = null;
   }
   
   public function isSetError() : Boolean
   {
      return this.error != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            break;
         case ERROR:
            if(param2 == null)
            {
               this.unsetError();
            }
            else
            {
               this.error = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         case ERROR:
            return this.error;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         case ERROR:
            return this.isSetError();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERROR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.error = new ZaapError();
                  this.error.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
               break;
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      else if(this.isSetError())
      {
         param1.writeFieldBegin(ERROR_FIELD_DESC);
         this.error.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:* = new String("auth_getGameTokenWithWindowId_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "error:";
      if(this.error == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.error;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}
