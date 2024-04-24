package com.ankamagames.dofus.network.types.game.context.roleplay.alignment.war.effort
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AlignmentWarEffortInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1570;
       
      
      public var alignmentSide:int = 0;
      
      public var alignmentWarEffort:Number = 0;
      
      public function AlignmentWarEffortInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1570;
      }
      
      public function initAlignmentWarEffortInformation(alignmentSide:int = 0, alignmentWarEffort:Number = 0) : AlignmentWarEffortInformation
      {
         this.alignmentSide = alignmentSide;
         this.alignmentWarEffort = alignmentWarEffort;
         return this;
      }
      
      public function reset() : void
      {
         this.alignmentSide = 0;
         this.alignmentWarEffort = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AlignmentWarEffortInformation(output);
      }
      
      public function serializeAs_AlignmentWarEffortInformation(output:ICustomDataOutput) : void
      {
         output.writeByte(this.alignmentSide);
         if(this.alignmentWarEffort < 0 || this.alignmentWarEffort > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffort + ") on element alignmentWarEffort.");
         }
         output.writeVarLong(this.alignmentWarEffort);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlignmentWarEffortInformation(input);
      }
      
      public function deserializeAs_AlignmentWarEffortInformation(input:ICustomDataInput) : void
      {
         this._alignmentSideFunc(input);
         this._alignmentWarEffortFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlignmentWarEffortInformation(tree);
      }
      
      public function deserializeAsyncAs_AlignmentWarEffortInformation(tree:FuncTree) : void
      {
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._alignmentWarEffortFunc);
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _alignmentWarEffortFunc(input:ICustomDataInput) : void
      {
         this.alignmentWarEffort = input.readVarUhLong();
         if(this.alignmentWarEffort < 0 || this.alignmentWarEffort > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.alignmentWarEffort + ") on element of AlignmentWarEffortInformation.alignmentWarEffort.");
         }
      }
   }
}
