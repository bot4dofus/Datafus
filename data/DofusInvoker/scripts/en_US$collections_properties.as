package
{
   import mx.resources.ResourceBundle;
   
   [ExcludeClass]
   public class en_US$collections_properties extends ResourceBundle
   {
       
      
      public function en_US$collections_properties()
      {
         super("en_US","collections");
      }
      
      override protected function getContent() : Object
      {
         return {
            "findCondition":"Find criteria must contain all sort fields leading up to \'{0}\'.",
            "getItemIndexError":"getItemIndex() is not available in this class.",
            "noComparatorSortField":"Cannot determine comparator for SortField with name \'{0}\'.",
            "outOfBounds":"Index \'{0}\' specified is out of bounds.",
            "removeAllError":"removeAll() is not available in this class.",
            "nonUnique":"Non-unique values in items.",
            "incorrectAddition":"Attempt to add an item already in the view.",
            "addItemError":"addItem() is not available in this class.",
            "getItemAtError":"getItemAt() is not available in this class.",
            "findRestriction":"Find criteria must contain at least one sort field value.",
            "stepSizeError":"stepSize cannot be set to a value of zero.",
            "invalidType":"Incorrect type. Must be of type XML or a XMLList that contains one XML object. ",
            "unknownMode":"Unknown find mode.",
            "addItemAtError":"addItemAt() is not available in this class.",
            "removeItemError":"removeItem() is not available in this class. Instead, use a combination of minimum, maximum and stepSize.",
            "invalidIndex":"Invalid index: \'{0}\'.",
            "invalidRemove":"Cannot remove when current is beforeFirst or afterLast.",
            "toArrayError":"toArray() is not available in this class.",
            "unknownProperty":"Unknown Property: \'{0}\'.",
            "lengthError":"length() is not available in this class.",
            "invalidInsert":"Cannot insert when current is beforeFirst.",
            "itemNotFound":"Cannot find when view is not sorted.",
            "bookmarkInvalid":"Bookmark no longer valid.",
            "itemUpdatedError":"itemUpdated() is not available in this class.",
            "noComparator":"Cannot determine comparator for \'{0}\'.",
            "setItemAtError":"setItemAt() is not available in this class.",
            "invalidCursor":"Cursor no longer valid.",
            "noItems":"No items to search.",
            "bookmarkNotFound":"Bookmark is not from this view.",
            "removeItemAtError":"removeItemAt() is not available in this class."
         };
      }
   }
}
