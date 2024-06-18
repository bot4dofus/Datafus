package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Preset implements INetworkType
   {
      
      public static const protocolId:uint = 3628;
       
      
      public var id:int = 0;
      
      public function Preset()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3628;
      }
      
      public function initPreset(id:int = 0) : Preset
      {
         this.id = id;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Preset(output);
      }
      
      public function serializeAs_Preset(output:ICustomDataOutput) : void
      {
         output.writeShort(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Preset(input);
      }
      
      public function deserializeAs_Preset(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Preset(tree);
      }
      
      public function deserializeAsyncAs_Preset(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readShort();
      }
   }
}
