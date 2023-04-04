package com.ankamagames.dofus.network.types.game.idol
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Idol implements INetworkType
   {
      
      public static const protocolId:uint = 4978;
       
      
      public var id:uint = 0;
      
      public var xpBonusPercent:uint = 0;
      
      public var dropBonusPercent:uint = 0;
      
      public function Idol()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4978;
      }
      
      public function initIdol(id:uint = 0, xpBonusPercent:uint = 0, dropBonusPercent:uint = 0) : Idol
      {
         this.id = id;
         this.xpBonusPercent = xpBonusPercent;
         this.dropBonusPercent = dropBonusPercent;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.xpBonusPercent = 0;
         this.dropBonusPercent = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Idol(output);
      }
      
      public function serializeAs_Idol(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
         if(this.xpBonusPercent < 0)
         {
            throw new Error("Forbidden value (" + this.xpBonusPercent + ") on element xpBonusPercent.");
         }
         output.writeVarShort(this.xpBonusPercent);
         if(this.dropBonusPercent < 0)
         {
            throw new Error("Forbidden value (" + this.dropBonusPercent + ") on element dropBonusPercent.");
         }
         output.writeVarShort(this.dropBonusPercent);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Idol(input);
      }
      
      public function deserializeAs_Idol(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._xpBonusPercentFunc(input);
         this._dropBonusPercentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Idol(tree);
      }
      
      public function deserializeAsyncAs_Idol(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._xpBonusPercentFunc);
         tree.addChild(this._dropBonusPercentFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of Idol.id.");
         }
      }
      
      private function _xpBonusPercentFunc(input:ICustomDataInput) : void
      {
         this.xpBonusPercent = input.readVarUhShort();
         if(this.xpBonusPercent < 0)
         {
            throw new Error("Forbidden value (" + this.xpBonusPercent + ") on element of Idol.xpBonusPercent.");
         }
      }
      
      private function _dropBonusPercentFunc(input:ICustomDataInput) : void
      {
         this.dropBonusPercent = input.readVarUhShort();
         if(this.dropBonusPercent < 0)
         {
            throw new Error("Forbidden value (" + this.dropBonusPercent + ") on element of Idol.dropBonusPercent.");
         }
      }
   }
}
