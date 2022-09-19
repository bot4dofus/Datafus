package Ankama_Fight.ui.slaves
{
   public class SlaveFightUiDescr
   {
       
      
      public var uiId:uint;
      
      public var slaveId:Number = 1.7976931348623157E308;
      
      public function SlaveFightUiDescr(ui:uint, entityId:Number)
      {
         this.uiId = SlaveFightUi.INVALID_UI_ID;
         super();
         this.uiId = ui;
         this.slaveId = entityId;
      }
   }
}
