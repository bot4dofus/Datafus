package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.types.Uri;
   
   public class Theme
   {
      
      public static const TYPE_OLD:uint = 0;
      
      public static const TYPE_NEW:uint = 1;
       
      
      public var id:String;
      
      public var name:String;
      
      public var author:String;
      
      public var description:String;
      
      public var previewUri:String;
      
      public var fileName:String;
      
      public var type:uint;
      
      public var folderFullPath:String;
      
      public var official:Boolean;
      
      public var version:Array;
      
      public var dofusVersion:Array;
      
      public var creationDate:String;
      
      public var modificationDate:String;
      
      public var data:Object;
      
      public function Theme(id:String, fileName:String, folderFullPath:String, name:String, author:String, description:String = "", previewUri:String = "", type:uint = 1, official:Boolean = false, version:Array = null, dofusVersion:Array = null, creationDate:String = "", modificationDate:String = "")
      {
         super();
         this.id = id;
         this.name = name;
         this.author = author;
         this.description = description;
         this.previewUri = previewUri;
         this.fileName = fileName;
         this.type = type;
         this.folderFullPath = folderFullPath;
         this.official = official;
         this.version = version == null ? new Array(0,0,0) : version;
         this.dofusVersion = dofusVersion == null ? new Array(0,0,0) : dofusVersion;
         this.creationDate = creationDate;
         this.modificationDate = modificationDate;
      }
      
      public function get previewRealUri() : Uri
      {
         return new Uri(this.folderFullPath + "bitmap/" + this.previewUri,false);
      }
   }
}
