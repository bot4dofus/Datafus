package com.ankamagames.dofus.misc.stats.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.misc.stats.ui.IUiStats;
   
   public interface IComponentStats extends IUiStats
   {
       
      
      function get component() : GraphicContainer;
   }
}
