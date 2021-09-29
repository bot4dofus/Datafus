package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.communication.DelayedActionItem;
   import com.ankamagames.dofus.network.enums.DelayedActionTypeEnum;
   
   public class DelayedActionTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _iconUrl:String;
      
      private var _data:DelayedActionItem;
      
      public function DelayedActionTooltipBlock(data:DelayedActionItem)
      {
         var item:Item = null;
         super();
         this._data = data;
         switch(data.type)
         {
            case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
               item = Api.data.getItem(data.dataId);
               if(item)
               {
                  this._iconUrl = "[config.gfx.path.item.bitmap]" + item.iconId + ".png";
               }
         }
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/world/delayedAction.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         var backgroundName:String = null;
         switch(this._data.type)
         {
            case DelayedActionTypeEnum.DELAYED_ACTION_OBJECT_USE:
               backgroundName = "[local.assets]delayedItemUse";
         }
         _content = _block.getChunk("content").processContent({
            "uri":this._iconUrl,
            "backName":backgroundName
         });
      }
   }
}
