package com.ankamagames.jerakine.interfaces
{
   import com.ankamagames.jerakine.types.Uri;
   
   public interface ISlotData
   {
       
      
      function get iconUri() : Uri;
      
      function get fullSizeIconUri() : Uri;
      
      function get errorIconUri() : Uri;
      
      function get info1() : String;
      
      function get active() : Boolean;
      
      function get timer() : int;
      
      function get startTime() : int;
      
      function get endTime() : int;
      
      function set endTime(param1:int) : void;
      
      function addHolder(param1:ISlotDataHolder) : void;
      
      function removeHolder(param1:ISlotDataHolder) : void;
   }
}
