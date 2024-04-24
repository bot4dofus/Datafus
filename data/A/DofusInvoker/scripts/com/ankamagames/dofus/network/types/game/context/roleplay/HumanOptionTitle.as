package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionTitle extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 2153;
       
      
      public var titleId:uint = 0;
      
      public var titleParam:String = "";
      
      public function HumanOptionTitle()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2153;
      }
      
      public function initHumanOptionTitle(titleId:uint = 0, titleParam:String = "") : HumanOptionTitle
      {
         this.titleId = titleId;
         this.titleParam = titleParam;
         return this;
      }
      
      override public function reset() : void
      {
         this.titleId = 0;
         this.titleParam = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionTitle(output);
      }
      
      public function serializeAs_HumanOptionTitle(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
         }
         output.writeVarShort(this.titleId);
         output.writeUTF(this.titleParam);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionTitle(input);
      }
      
      public function deserializeAs_HumanOptionTitle(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._titleIdFunc(input);
         this._titleParamFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionTitle(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionTitle(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._titleIdFunc);
         tree.addChild(this._titleParamFunc);
      }
      
      private function _titleIdFunc(input:ICustomDataInput) : void
      {
         this.titleId = input.readVarUhShort();
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element of HumanOptionTitle.titleId.");
         }
      }
      
      private function _titleParamFunc(input:ICustomDataInput) : void
      {
         this.titleParam = input.readUTF();
      }
   }
}
