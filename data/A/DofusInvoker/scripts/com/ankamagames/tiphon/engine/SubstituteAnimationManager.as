package com.ankamagames.tiphon.engine
{
   public final class SubstituteAnimationManager
   {
      
      private static var _like:Vector.<String> = new Vector.<String>();
      
      private static var _defaultAnimations:Vector.<String> = new Vector.<String>();
       
      
      public function SubstituteAnimationManager()
      {
         super();
      }
      
      public static function setDefaultAnimation(like:String, defaultAnim:String) : void
      {
         var indexLike:int = _like.indexOf(like);
         if(indexLike == -1)
         {
            _like.push(like);
            _defaultAnimations.push(defaultAnim);
         }
         else
         {
            _defaultAnimations[indexLike] = defaultAnim;
         }
      }
      
      public static function getDefaultAnimation(currentAnimation:String) : String
      {
         var like:String = null;
         for each(like in _like)
         {
            if(currentAnimation.indexOf(like) == 0)
            {
               return _defaultAnimations[_like.indexOf(like)];
            }
         }
         return null;
      }
   }
}
