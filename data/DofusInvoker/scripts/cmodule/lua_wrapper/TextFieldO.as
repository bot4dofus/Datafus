package cmodule.lua_wrapper
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   class TextFieldO extends IO
   {
       
      
      private var m_trace:Boolean;
      
      private var m_tf:TextField;
      
      function TextFieldO(param1:TextField, param2:Boolean = false)
      {
         super();
         this.m_tf = param1;
         this.m_trace = param2;
      }
      
      override public function write(param1:int, param2:int) : int
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TextFormat = null;
         var _loc3_:int = param2;
         _loc4_ = "";
         while(_loc3_--)
         {
            _loc4_ += String.fromCharCode(gstate._mru8(param1));
            param1++;
         }
         if(this.m_trace)
         {
            trace(_loc4_);
         }
         _loc5_ = this.m_tf.length;
         this.m_tf.replaceText(_loc5_,_loc5_,_loc4_);
         _loc6_ = this.m_tf.length;
         _loc7_ = this.m_tf.getTextFormat(_loc5_,_loc6_);
         _loc7_.bold = true;
         this.m_tf.setTextFormat(_loc7_,_loc5_,_loc6_);
         this.m_tf.setSelection(_loc6_,_loc6_);
         return param2;
      }
   }
}
