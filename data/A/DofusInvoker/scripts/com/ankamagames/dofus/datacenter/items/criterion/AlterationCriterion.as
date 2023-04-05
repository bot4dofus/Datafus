package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.alterations.Alteration;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.AlterationFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AlterationCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AlterationCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         if(_operator.text !== ItemCriterionOperator.EQUAL && _operator.text !== ItemCriterionOperator.DIFFERENT)
         {
            return false;
         }
         var alteration:AlterationWrapper = null;
         var alterationFrame:AlterationFrame = Kernel.getWorker().getFrame(AlterationFrame) as AlterationFrame;
         if(alterationFrame !== null)
         {
            alteration = alterationFrame.getNewAlterationFromBddId(criterionValue as uint);
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return alteration !== null;
            case ItemCriterionOperator.DIFFERENT:
               return alteration == null;
            default:
               return false;
         }
      }
      
      override public function clone() : IItemCriterion
      {
         return new AlterationCriterion(this.basicText);
      }
      
      override public function get text() : String
      {
         if(_operator.text !== ItemCriterionOperator.EQUAL && _operator.text !== ItemCriterionOperator.DIFFERENT)
         {
            return null;
         }
         var alterationData:Alteration = Alteration.getAlterationById(criterionValue as int);
         var alterationLabel:String = alterationData !== null ? alterationData.name : "???";
         if(PlayerManager.getInstance().hasRights)
         {
            alterationLabel += " (" + (alterationData !== null ? alterationData.id : "?") + ")";
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return I18n.getUiText("ui.item.hasAlteration",[alterationLabel]);
            case ItemCriterionOperator.DIFFERENT:
               return I18n.getUiText("ui.item.doesNotHaveAlteration",[alterationLabel]);
            default:
               return null;
         }
      }
   }
}
