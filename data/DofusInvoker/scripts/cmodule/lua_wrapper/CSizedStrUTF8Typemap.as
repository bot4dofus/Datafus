package cmodule.lua_wrapper
{
   class CSizedStrUTF8Typemap extends CTypemap
   {
       
      
      function CSizedStrUTF8Typemap()
      {
         super();
      }
      
      override public function fromC(param1:Array) : *
      {
         mstate.ds.position = param1[0];
         return mstate.ds.readUTFBytes(param1[1]);
      }
      
      override public function get typeSize() : int
      {
         return 8;
      }
   }
}
