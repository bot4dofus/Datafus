package com.ankamagames.dofus.datacenter.documents
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Document implements IDataCenter
   {
      
      private static const MODULE:String = "Documents";
      
      private static const PAGEFEED:String = "<pagefeed/>";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getDocumentById,getDocuments);
       
      
      public var id:int;
      
      public var typeId:uint;
      
      public var showTitle:Boolean;
      
      public var showBackgroundImage:Boolean;
      
      public var titleId:uint;
      
      public var authorId:uint;
      
      public var subTitleId:uint;
      
      public var contentId:uint;
      
      public var contentCSS:String;
      
      public var clientProperties:String;
      
      private var _title:String;
      
      private var _author:String;
      
      private var _subTitle:String;
      
      private var _content:String;
      
      private var _pages:Array;
      
      public function Document()
      {
         super();
      }
      
      public static function getDocumentById(id:int) : Document
      {
         return GameData.getObject(MODULE,id) as Document;
      }
      
      public static function getDocuments() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get title() : String
      {
         if(!this._title)
         {
            this._title = I18n.getText(this.titleId);
         }
         return this._title;
      }
      
      public function get author() : String
      {
         if(!this._author)
         {
            this._author = I18n.getText(this.authorId);
         }
         return this._author;
      }
      
      public function get subTitle() : String
      {
         if(!this._subTitle)
         {
            this._subTitle = I18n.getText(this.subTitleId);
            if(this._subTitle.charAt(0) == "[")
            {
               this._subTitle = "";
            }
         }
         return this._subTitle;
      }
      
      public function get content() : String
      {
         if(!this._content)
         {
            this._content = I18n.getText(this.contentId);
         }
         return this._content;
      }
      
      public function get pages() : Array
      {
         if(!this._pages)
         {
            this._pages = this.content.split(PAGEFEED);
         }
         return this._pages;
      }
   }
}
