package Ankama_GameUiCore.ui.params
{
   public class ActionBarParameters
   {
       
      
      public var id:uint;
      
      public var orientation:uint;
      
      public var orientationChanged:Boolean;
      
      public var context:String;
      
      public function ActionBarParameters(pId:uint, pOrientation:uint, pOrientationChanged:Boolean, pContext:String)
      {
         super();
         this.id = pId;
         this.orientation = pOrientation;
         this.orientationChanged = pOrientationChanged;
         this.context = pContext;
      }
   }
}
