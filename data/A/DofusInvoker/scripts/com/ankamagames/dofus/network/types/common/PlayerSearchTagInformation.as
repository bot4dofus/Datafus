package com.ankamagames.dofus.network.types.common
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PlayerSearchTagInformation extends AbstractPlayerSearchInformation implements INetworkType
   {
      
      public static const protocolId:uint = 3389;
       
      
      public var tag:AccountTagInformation;
      
      private var _tagtree:FuncTree;
      
      public function PlayerSearchTagInformation()
      {
         this.tag = new AccountTagInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3389;
      }
      
      public function initPlayerSearchTagInformation(tag:AccountTagInformation = null) : PlayerSearchTagInformation
      {
         this.tag = tag;
         return this;
      }
      
      override public function reset() : void
      {
         this.tag = new AccountTagInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PlayerSearchTagInformation(output);
      }
      
      public function serializeAs_PlayerSearchTagInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPlayerSearchInformation(output);
         this.tag.serializeAs_AccountTagInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerSearchTagInformation(input);
      }
      
      public function deserializeAs_PlayerSearchTagInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.tag = new AccountTagInformation();
         this.tag.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerSearchTagInformation(tree);
      }
      
      public function deserializeAsyncAs_PlayerSearchTagInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._tagtree = tree.addChild(this._tagtreeFunc);
      }
      
      private function _tagtreeFunc(input:ICustomDataInput) : void
      {
         this.tag = new AccountTagInformation();
         this.tag.deserializeAsync(this._tagtree);
      }
   }
}
