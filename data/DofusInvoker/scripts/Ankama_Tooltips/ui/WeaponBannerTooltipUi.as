package Ankama_Tooltips.ui
{
   import flash.events.TimerEvent;
   
   public class WeaponBannerTooltipUi extends SpellBannerTooltipUi
   {
       
      
      public function WeaponBannerTooltipUi()
      {
         super();
      }
      
      override protected function onTimer(e:TimerEvent) : void
      {
         if(_timerShowSpellTooltip)
         {
            _timerShowSpellTooltip.removeEventListener(TimerEvent.TIMER,this.onTimer);
            _timerShowSpellTooltip.stop();
            _timerShowSpellTooltip = null;
         }
         if(_params.data.makerParams.hasOwnProperty("contextual"))
         {
            _params.data.makerParams.contextual = true;
         }
         uiApi.showTooltip(_params.data.weapon,_params.data.makerParams.hasOwnProperty("ref") && _params.data.makerParams.ref != null ? _params.data.makerParams.ref : _params.position,false,"standard",_params.point,_params.relativePoint,_params.offset,null,null,_params.data.makerParams);
      }
   }
}
