package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class DocumentApi implements IApi
   {
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function DocumentApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(DocumentApi));
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getDocument(pDocId:uint) : Document
      {
         return Document.getDocumentById(pDocId);
      }
      
      public function getType(pDocId:uint) : uint
      {
         return Document.getDocumentById(pDocId).typeId;
      }
   }
}
