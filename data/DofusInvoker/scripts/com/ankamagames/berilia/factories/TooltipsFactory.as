package com.ankamagames.berilia.factories
{
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.tooltip.EmptyTooltip;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import flash.utils.getQualifiedClassName;
   
   public class TooltipsFactory
   {
      
      private static var _registeredMaker:Array = new Array();
      
      private static var _makerAssoc:Array = new Array();
       
      
      public function TooltipsFactory()
      {
         super();
      }
      
      public static function registerMaker(makerName:String, maker:Class, scriptClass:Class = null) : void
      {
         _registeredMaker[makerName] = new TooltipData(maker,scriptClass);
      }
      
      public static function registerAssoc(dataClass:*, makerName:String) : void
      {
         _makerAssoc[getQualifiedClassName(dataClass)] = makerName;
      }
      
      public static function existRegisterMaker(makerName:String) : Boolean
      {
         return !!_registeredMaker[makerName] ? true : false;
      }
      
      public static function getMakerInstance(makerName:String) : Object
      {
         var ttData:TooltipData = _registeredMaker[makerName];
         return !!ttData ? new ttData.maker() : null;
      }
      
      public static function existMakerAssoc(dataClass:*) : Boolean
      {
         return !!_makerAssoc[getQualifiedClassName(dataClass)] ? true : false;
      }
      
      public static function unregister(dataType:Class, maker:Class) : void
      {
         if(TooltipData(_registeredMaker[getQualifiedClassName(dataType)]).maker === maker)
         {
            delete _registeredMaker[getQualifiedClassName(dataType)];
         }
      }
      
      public static function create(data:*, makerName:String = null, script:Class = null, makerParam:Object = null) : Tooltip
      {
         var maker:* = undefined;
         var tt:Tooltip = null;
         var toolt:Object = null;
         if(!makerName)
         {
            makerName = _makerAssoc[getQualifiedClassName(data)];
         }
         var td:TooltipData = _registeredMaker[makerName];
         if(td)
         {
            maker = new td.maker();
            toolt = maker.createTooltip(data,makerParam);
            if(toolt == "")
            {
               return new EmptyTooltip();
            }
            tt = toolt as Tooltip;
            if(tt == null)
            {
               return null;
            }
            if(TooltipManager.defaultTooltipUiScript == script)
            {
               tt.scriptClass = !!td.scriptClass ? td.scriptClass : script;
            }
            else
            {
               tt.scriptClass = script;
            }
            tt.makerName = makerName;
            return tt;
         }
         return null;
      }
   }
}

class TooltipData
{
    
   
   public var maker:Class;
   
   public var scriptClass:Class;
   
   function TooltipData(maker:Class, scriptClass:Class)
   {
      super();
      this.maker = maker;
      this.scriptClass = scriptClass;
   }
}
