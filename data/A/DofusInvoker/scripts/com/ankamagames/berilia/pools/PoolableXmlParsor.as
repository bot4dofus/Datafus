package com.ankamagames.berilia.pools
{
   import com.ankamagames.berilia.uiRender.XmlParsor;
   import com.ankamagames.jerakine.pools.Poolable;
   
   public class PoolableXmlParsor extends XmlParsor implements Poolable
   {
       
      
      public function PoolableXmlParsor()
      {
         super();
      }
      
      public function free() : void
      {
         _xmlDoc = null;
         _sUrl = null;
         _aName = null;
         _glPoint = null;
         rootPath = null;
      }
   }
}
