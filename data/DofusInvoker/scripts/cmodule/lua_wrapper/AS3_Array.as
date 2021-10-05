package cmodule.lua_wrapper
{
   function AS3_Array(param1:String, param2:int) : *
   {
      var _loc3_:Array = null;
      var _loc4_:Array = null;
      var _loc5_:int = 0;
      var _loc6_:CTypemap = null;
      var _loc7_:int = 0;
      var _loc8_:Array = null;
      _loc3_ = [];
      if(!param1 || !param1.length)
      {
         return _loc3_;
      }
      _loc4_ = CTypemap.getTypesByNames(param1);
      _loc5_ = 0;
      while(_loc5_ < _loc4_.length)
      {
         _loc6_ = _loc4_[_loc5_];
         _loc7_ = _loc6_.typeSize;
         _loc8_ = [];
         mstate.ds.position = param2;
         param2 += _loc7_;
         while(_loc7_)
         {
            _loc8_.push(mstate.ds.readInt());
            _loc7_ -= 4;
         }
         _loc3_.push(_loc6_.fromC(_loc8_));
         _loc5_++;
      }
      return _loc3_;
   }
}
