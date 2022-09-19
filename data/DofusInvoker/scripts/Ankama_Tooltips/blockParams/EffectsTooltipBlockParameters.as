package Ankama_Tooltips.blockParams
{
   public class EffectsTooltipBlockParameters extends TooltipBlockParameters
   {
       
      
      public var effects:Object;
      
      public var isCriticalEffects:Boolean = false;
      
      public var setInfo:String;
      
      public var splitDamageAndEffects:Boolean = true;
      
      public var length:int = 409;
      
      public var showDamages:Boolean = true;
      
      public var showSpecialEffects:Boolean = true;
      
      public var showTheoreticalEffects:Boolean = true;
      
      public var addTheoreticalEffects:Boolean = false;
      
      public var showDuration:Boolean = true;
      
      public var showLabel:Boolean = true;
      
      public var itemTheoreticalEffects:Object = null;
      
      public var customli:String = "customlirightmargin";
      
      public var fromBuff:Boolean = false;
      
      public var showTimeLeftFormat:Boolean = false;
      
      public function EffectsTooltipBlockParameters()
      {
         super();
      }
      
      public static function create(effects:Object, chunkType:String = "chunks") : EffectsTooltipBlockParameters
      {
         var params:EffectsTooltipBlockParameters = new EffectsTooltipBlockParameters();
         params.effects = effects;
         params.chunkType = chunkType;
         return params;
      }
   }
}
