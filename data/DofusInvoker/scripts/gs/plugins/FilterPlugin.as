package gs.plugins
{
   import flash.filters.BitmapFilter;
   import gs.core.PropTween;
   
   public class FilterPlugin extends TweenPlugin
   {
      
      public static const VERSION:Number = 2.03;
      
      public static const API:Number = 1;
       
      
      protected var _target:Object;
      
      protected var _type:Class;
      
      protected var _filter:BitmapFilter;
      
      protected var _index:int;
      
      protected var _remove:Boolean;
      
      public function FilterPlugin()
      {
         super();
      }
      
      protected function initFilter(props:Object, defaultFilter:BitmapFilter, propNames:Array) : void
      {
         var p:String = null;
         var i:int = 0;
         var colorTween:HexColorsPlugin = null;
         var filters:Array = this._target.filters;
         var extras:Object = props is BitmapFilter ? {} : props;
         this._index = -1;
         if(extras.index != null)
         {
            this._index = extras.index;
         }
         else
         {
            i = filters.length;
            while(i--)
            {
               if(filters[i] is this._type)
               {
                  this._index = i;
                  break;
               }
            }
         }
         if(this._index == -1 || filters[this._index] == null || extras.addFilter == true)
         {
            this._index = extras.index != null ? int(extras.index) : int(filters.length);
            filters[this._index] = defaultFilter;
            this._target.filters = filters;
         }
         this._filter = filters[this._index];
         if(extras.remove == true)
         {
            this._remove = true;
            this.onComplete = this.onCompleteTween;
         }
         i = propNames.length;
         while(i--)
         {
            p = propNames[i];
            if(p in props && this._filter[p] != props[p])
            {
               if(p == "color" || p == "highlightColor" || p == "shadowColor")
               {
                  colorTween = new HexColorsPlugin();
                  colorTween.initColor(this._filter,p,this._filter[p],props[p]);
                  _tweens[_tweens.length] = new PropTween(colorTween,"changeFactor",0,1,p,false);
               }
               else if(p == "quality" || p == "inner" || p == "knockout" || p == "hideObject")
               {
                  this._filter[p] = props[p];
               }
               else
               {
                  addTween(this._filter,p,this._filter[p],props[p],p);
               }
            }
         }
      }
      
      public function onCompleteTween() : void
      {
         var filters:Array = null;
         var i:int = 0;
         if(this._remove)
         {
            filters = this._target.filters;
            if(!(filters[this._index] is this._type))
            {
               i = filters.length;
               while(i--)
               {
                  if(filters[i] is this._type)
                  {
                     filters.splice(i,1);
                     break;
                  }
               }
            }
            else
            {
               filters.splice(this._index,1);
            }
            this._target.filters = filters;
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ti:PropTween = null;
         var i:int = _tweens.length;
         var filters:Array = this._target.filters;
         while(i--)
         {
            ti = _tweens[i];
            ti.target[ti.property] = ti.start + ti.change * n;
         }
         if(!(filters[this._index] is this._type))
         {
            i = this._index = filters.length;
            while(i--)
            {
               if(filters[i] is this._type)
               {
                  this._index = i;
                  break;
               }
            }
         }
         filters[this._index] = this._filter;
         this._target.filters = filters;
      }
   }
}
