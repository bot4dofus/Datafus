package com.ankamagames.dofus.network.types.game.surrender
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderRefusedBeforeTurn extends SurrenderRefused implements INetworkType
   {
      
      public static const protocolId:uint = 9548;
       
      
      public var minTurnForSurrender:int = 0;
      
      public function SurrenderRefusedBeforeTurn()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9548;
      }
      
      public function initSurrenderRefusedBeforeTurn(minTurnForSurrender:int = 0) : SurrenderRefusedBeforeTurn
      {
         this.minTurnForSurrender = minTurnForSurrender;
         return this;
      }
      
      override public function reset() : void
      {
         this.minTurnForSurrender = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SurrenderRefusedBeforeTurn(output);
      }
      
      public function serializeAs_SurrenderRefusedBeforeTurn(output:ICustomDataOutput) : void
      {
         super.serializeAs_SurrenderRefused(output);
         output.writeInt(this.minTurnForSurrender);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderRefusedBeforeTurn(input);
      }
      
      public function deserializeAs_SurrenderRefusedBeforeTurn(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._minTurnForSurrenderFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderRefusedBeforeTurn(tree);
      }
      
      public function deserializeAsyncAs_SurrenderRefusedBeforeTurn(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._minTurnForSurrenderFunc);
      }
      
      private function _minTurnForSurrenderFunc(input:ICustomDataInput) : void
      {
         this.minTurnForSurrender = input.readInt();
      }
   }
}
