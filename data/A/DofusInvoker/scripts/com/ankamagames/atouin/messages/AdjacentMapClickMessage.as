package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class AdjacentMapClickMessage implements Message
   {
       
      
      public var adjacentMapId:Number;
      
      public var cellId:uint;
      
      public var fromStack:Boolean;
      
      public var fromAutotrip:Boolean;
      
      public function AdjacentMapClickMessage()
      {
         super();
      }
   }
}
