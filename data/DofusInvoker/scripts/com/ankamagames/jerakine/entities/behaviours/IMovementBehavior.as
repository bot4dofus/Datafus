package com.ankamagames.jerakine.entities.behaviours
{
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import flash.display.DisplayObject;
   
   public interface IMovementBehavior
   {
       
      
      function move(param1:IMovable, param2:MovementPath, param3:Function = null) : void;
      
      function jump(param1:IMovable, param2:MapPoint) : void;
      
      function stop(param1:IMovable, param2:Boolean = false) : void;
      
      function isMoving(param1:IMovable) : Boolean;
      
      function synchroniseSubEntitiesPosition(param1:IMovable, param2:DisplayObject = null) : void;
   }
}
