class com.rockstargames.gtav.levelDesign.vehspawn.ImageManager
{
   static var USE_REFERENCE_COUNTING = false;
   function ImageManager()
   {
      this.txdRefs = [];
      this.imageQueue = [];
   }
   function addImage(txd, id, imageTextField)
   {
      if(com.rockstargames.gtav.levelDesign.vehspawn.ImageManager.USE_REFERENCE_COUNTING && this.txdRefs[txd] == "loaded")
      {
         this.displayImage(txd,id,imageTextField);
      }
      else
      {
         if(this.txdRefs[txd] != "loading")
         {
            com.rockstargames.ui.game.GameInterface.call("REQUEST_TXD_AND_ADD_REF",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SPAWN_MENU",txd,id,true);
            this.txdRefs[txd] = "loading";
         }
         this.imageQueue.push({txd:txd,id:id,path:String(imageTextField)});
      }
   }
   function textureLoaded(txd)
   {
      this.txdRefs[txd] = "loaded";
      var _loc6_ = this.imageQueue.length - 1;
      while(_loc6_ >= 0)
      {
         var _loc7_ = this.imageQueue[_loc6_];
         if(_loc7_.txd == txd)
         {
            var _loc5_ = _loc7_.path.split(".");
            var _loc4_ = _root;
            var _loc3_ = 1;
            while(_loc3_ < _loc5_.length)
            {
               _loc4_ = _loc4_[_loc5_[_loc3_]];
               _loc3_ = _loc3_ + 1;
            }
            if(_loc4_)
            {
               this.displayImage(txd,_loc7_.id,TextField(_loc4_));
            }
            this.imageQueue.splice(_loc6_,1);
         }
         _loc6_ = _loc6_ - 1;
      }
   }
   function clearImageQueue()
   {
      this.imageQueue.length = 0;
   }
   function displayImage(txd, id, imageTextField)
   {
      var _loc3_ = Math.round(imageTextField._width - 4);
      var _loc2_ = Math.round(imageTextField._height - 4);
      imageTextField.htmlText = "<img src=\'img://" + txd + "/" + id + "\' vspace=\'0\' hspace=\'0\' width=\'" + _loc3_ + "\' height=\'" + _loc2_ + "\'/>";
   }
   function dispose()
   {
      for(var _loc2_ in this.txdRefs)
      {
         com.rockstargames.ui.game.GameInterface.call("REMOVE_TXD_REF",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SPAWN_MENU",_loc2_);
      }
   }
}
