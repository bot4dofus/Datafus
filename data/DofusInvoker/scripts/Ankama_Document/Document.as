package Ankama_Document
{
   import Ankama_Common.Common;
   import Ankama_Document.ui.ReadingBook;
   import Ankama_Document.ui.Scroll;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.uiApi.DocumentApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Document extends Sprite
   {
      
      private static const TYPE_BOOK:uint = 1;
      
      private static const TYPE_SCROLL:uint = 2;
       
      
      protected var readingBook:ReadingBook;
      
      protected var scroll:Scroll;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DocumentApi")]
      public var docApi:DocumentApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public function Document()
      {
         super();
      }
      
      public function main() : void
      {
         this.sysApi.addHook(RoleplayHookList.DocumentReadingBegin,this.onDocumentReadingBegin);
      }
      
      private function onDocumentReadingBegin(documentId:uint) : void
      {
         var typeId:uint = this.docApi.getType(documentId);
         switch(typeId)
         {
            case TYPE_BOOK:
               if(!this.uiApi.getUi("readingBook"))
               {
                  this.uiApi.loadUi("readingBook","readingBook",{"documentId":documentId});
               }
               break;
            case TYPE_SCROLL:
               if(!this.uiApi.getUi("scroll2"))
               {
                  this.uiApi.loadUi("scroll2","scroll",{"documentId":documentId});
               }
         }
      }
   }
}
