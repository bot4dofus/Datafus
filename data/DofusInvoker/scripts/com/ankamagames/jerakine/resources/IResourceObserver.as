package com.ankamagames.jerakine.resources
{
   import com.ankamagames.jerakine.types.Uri;
   
   public interface IResourceObserver
   {
       
      
      function onLoaded(param1:Uri, param2:uint, param3:*) : void;
      
      function onFailed(param1:Uri, param2:String, param3:uint) : void;
      
      function onProgress(param1:Uri, param2:uint, param3:uint) : void;
   }
}
