class com.rockstargames.gtav.levelDesign.vehspawn.Button
{
   function Button(id, view)
   {
      this.id = id;
      this.view = view;
      this.depth = id;
      this.updateBounds();
   }
   function disable()
   {
      this.view._alpha = 50;
   }
   function enable()
   {
      this.view._alpha = 100;
   }
   function setState(state)
   {
      if(state != this.currState)
      {
         this.view.gotoAndStop(state);
         this.currState = state;
      }
   }
   function updateBounds()
   {
      var _loc3_ = this.view.getBounds(_root);
      this.left = _loc3_.xMin;
      this.right = _loc3_.xMax;
      this.top = _loc3_.yMin;
      this.bottom = _loc3_.yMax;
   }
}
