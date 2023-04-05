package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.jerakine.utils.crypto.SignatureKey;
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   
   public class SignedFileAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      private static var _defaultSignatureKey:SignatureKey;
       
      
      private var _signatureKey:SignatureKey;
      
      private var _uri:Uri;
      
      private var _resourceObserverWrapper:ResourceObserverWrapper;
      
      private var _resource;
      
      private var _rawContent:Boolean;
      
      public function SignedFileAdapter(signatureKey:SignatureKey = null, rawContent:Boolean = false)
      {
         super();
         this._rawContent = rawContent;
         if(signatureKey)
         {
            this._signatureKey = signatureKey;
         }
         else
         {
            this._signatureKey = _defaultSignatureKey;
         }
         if(!this._signatureKey)
         {
            throw new ArgumentError("A signature key must be defined (you can also set defaultSignatureKey)");
         }
      }
      
      public static function set defaultSignatureKey(v:SignatureKey) : void
      {
         _defaultSignatureKey = v;
      }
      
      public static function get defaultSignatureKey() : SignatureKey
      {
         return _defaultSignatureKey;
      }
      
      override public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         this._uri = uri;
         super.loadDirectly(uri,path,observer,dispatchProgress);
      }
      
      override public function loadFromData(uri:Uri, data:ByteArray, observer:IResourceObserver, dispatchProgress:Boolean) : void
      {
         this._uri = uri;
         super.loadFromData(uri,data,observer,dispatchProgress);
      }
      
      override public function free() : void
      {
         this._resource = null;
         this._resourceObserverWrapper = null;
         this._uri = null;
         super.free();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         return this._resource;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_SIGNED_FILE;
      }
      
      override protected function process(dataFormat:String, data:*) : void
      {
         var sig:Signature = new Signature(this._signatureKey);
         var content:ByteArray = new ByteArray();
         try
         {
            if(!sig.verify(data,content))
            {
               dispatchFailure("Invalid signature",ResourceErrorCode.INVALID_SIGNATURE);
               return;
            }
         }
         catch(e:Error)
         {
            dispatchFailure("Invalid signature : " + e.message,ResourceErrorCode.INVALID_SIGNATURE);
         }
         var contentUri:Uri = new Uri(this._uri.path.substr(0,this._uri.path.length - 1));
         var contentAdapter:IAdapter = AdapterFactory.getAdapter(contentUri);
         if(!contentAdapter)
         {
            dispatchFailure("Cannot found any adapted adpter for file content",ResourceErrorCode.INCOMPATIBLE_ADAPTER);
            return;
         }
         if(!this._rawContent)
         {
            if(!this._resourceObserverWrapper)
            {
               this._resourceObserverWrapper = new ResourceObserverWrapper(this.onContentLoad,this.onContentLoadFailed);
            }
            contentAdapter.loadFromData(this._uri,content,this._resourceObserverWrapper,false);
         }
         else
         {
            this.onContentLoad(this._uri,ResourceType.RESOURCE_BINARY,content);
         }
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
      
      private function onContentLoad(uri:Uri, resourceType:uint, resource:*) : void
      {
         this._resource = resource;
         dispatchSuccess(ResourceType.getName(resourceType),resource);
      }
      
      private function onContentLoadFailed(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         dispatchFailure(errorMsg,errorCode);
      }
   }
}
