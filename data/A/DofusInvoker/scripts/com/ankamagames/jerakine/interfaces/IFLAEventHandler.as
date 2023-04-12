package com.ankamagames.jerakine.interfaces
{
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   
   public interface IFLAEventHandler
   {
       
      
      function handleFLAEvent(param1:String, param2:String, param3:String, param4:Object = null) : void;
      
      function removeEntitySound(param1:IEntity) : void;
   }
}
