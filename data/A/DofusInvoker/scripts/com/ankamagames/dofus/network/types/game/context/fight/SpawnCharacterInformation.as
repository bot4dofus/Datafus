package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpawnCharacterInformation extends SpawnInformation implements INetworkType
   {
      
      public static const protocolId:uint = 3409;
       
      
      public var name:String = "";
      
      public var level:uint = 0;
      
      public function SpawnCharacterInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3409;
      }
      
      public function initSpawnCharacterInformation(name:String = "", level:uint = 0) : SpawnCharacterInformation
      {
         this.name = name;
         this.level = level;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
         this.level = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpawnCharacterInformation(output);
      }
      
      public function serializeAs_SpawnCharacterInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_SpawnInformation(output);
         output.writeUTF(this.name);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpawnCharacterInformation(input);
      }
      
      public function deserializeAs_SpawnCharacterInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
         this._levelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpawnCharacterInformation(tree);
      }
      
      public function deserializeAsyncAs_SpawnCharacterInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         tree.addChild(this._levelFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of SpawnCharacterInformation.level.");
         }
      }
   }
}
