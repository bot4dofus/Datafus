package com.ankamagames.berilia.pools
{
   import com.ankamagames.berilia.uiRender.UiRenderer;
   import com.ankamagames.jerakine.pools.Poolable;
   
   public class PoolableUiRenderer extends UiRenderer implements Poolable
   {
       
      
      public function PoolableUiRenderer()
      {
         super();
      }
      
      public function free() : void
      {
         _nTimeStamp = 0;
         _scUi = null;
      }
   }
}
