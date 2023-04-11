package com.ankamagames.jerakine.logger.targets
{
   public interface ConfigurableLoggingTarget extends LoggingTarget
   {
       
      
      function configure(param1:XML) : void;
   }
}
