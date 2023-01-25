package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   
   public class ComboBoxGrid extends Grid
   {
       
      
      private var _lastMouseUpFrameId:int = -1;
      
      public function ComboBoxGrid()
      {
         super();
      }
      
      override public function process(msg:Message) : Boolean
      {
         var mmsg:MouseMessage = null;
         var currentItem:GridItem = null;
         switch(true)
         {
            case msg is MouseDoubleClickMessage:
            case msg is MouseClickMessage:
               if(this._lastMouseUpFrameId == FrameIdManager.frameId)
               {
                  return false;
               }
               break;
            case msg is MouseUpMessage:
               break;
            default:
               return super.process(msg);
         }
         this._lastMouseUpFrameId = FrameIdManager.frameId;
         mmsg = MouseMessage(msg);
         currentItem = super.getGridItem(mmsg.target);
         if(currentItem)
         {
            if(!currentItem.data)
            {
               if(UIEventManager.getInstance().isRegisteredInstance(this,SelectEmptyItemMessage))
               {
                  super.dispatchMessage(new SelectEmptyItemMessage(this,SelectMethodEnum.CLICK));
               }
               setSelectedIndex(-1,SelectMethodEnum.CLICK);
            }
            setSelectedIndex(currentItem.index,SelectMethodEnum.CLICK);
         }
         return true;
      }
   }
}
