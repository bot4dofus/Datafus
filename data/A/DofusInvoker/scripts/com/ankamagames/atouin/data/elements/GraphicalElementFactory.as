package com.ankamagames.atouin.data.elements
{
   import com.ankamagames.atouin.data.elements.subtypes.AnimatedGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.BlendedGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.BoundingBoxGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.EntityGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.ParticlesGraphicalElementData;
   import com.ankamagames.jerakine.managers.ErrorManager;
   
   public class GraphicalElementFactory
   {
       
      
      public function GraphicalElementFactory()
      {
         super();
      }
      
      public static function getGraphicalElementData(elementId:int, elementType:int) : GraphicalElementData
      {
         switch(elementType)
         {
            case GraphicalElementTypes.NORMAL:
               return new NormalGraphicalElementData(elementId,elementType);
            case GraphicalElementTypes.BOUNDING_BOX:
               return new BoundingBoxGraphicalElementData(elementId,elementType);
            case GraphicalElementTypes.ANIMATED:
               return new AnimatedGraphicalElementData(elementId,elementType);
            case GraphicalElementTypes.ENTITY:
               return new EntityGraphicalElementData(elementId,elementType);
            case GraphicalElementTypes.PARTICLES:
               return new ParticlesGraphicalElementData(elementId,elementType);
            case GraphicalElementTypes.BLENDED:
               return new BlendedGraphicalElementData(elementId,elementType);
            default:
               ErrorManager.addError("Unknown graphical element data type " + elementType + " for element " + elementId + "!",null,false);
               return null;
         }
      }
   }
}
