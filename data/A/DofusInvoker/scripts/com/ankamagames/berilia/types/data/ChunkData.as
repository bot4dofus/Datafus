package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.types.Uri;
   
   public class ChunkData
   {
       
      
      public var name:String;
      
      public var uri:Uri;
      
      public function ChunkData(name:String, uri:Uri)
      {
         super();
         this.name = name;
         this.uri = uri;
      }
   }
}
