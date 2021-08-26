class com.rockstargames.gtav.levelDesign.vehspawn.HOMEPAGE extends com.rockstargames.gtav.levelDesign.vehspawn.Screen
{
   static var PROCEED = 100;
   function HOMEPAGE(app, viewContainer, cursor)
   {
      super(app,viewContainer,cursor,"HOMEPAGE");
      this.init();
   }
   function init()
   {
      this.initButtons();
      this.view._visible = true;
   }
   function __get__isReady()
   {
      return true;
   }

   function initButtons()
   {
      this.proceedButton = new com.rockstargames.gtav.levelDesign.vehspawn.Button(com.rockstargames.gtav.levelDesign.vehspawn.HOMEPAGE.PROCEED,this.view.proceedBtn)
      this.cursor.setTargetRects([this.proceedButton]);
   }

   function setPLAYER_NAME(str)
   {
      this.view.PLAYER_NAME.text = str;
   }

   function handleButtonInput(inputID)
   {
      if(inputID == com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.ACCEPT || inputID == com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.LEFT_MOUSE)
      {
         var curr_selection = this.app.GET_CURRENT_SELECTION();
         if( curr_selection == this.proceedButton.id)
         {
            com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.playSound("Log_In");
            this.showNextScreen();
         }
      }
      
   }
   function showNextScreen()
   {
      this.app.showScreen(this.app.CLASSES);
   }

   function dispose()
   {
      com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.view);
      super.dispose();
   }
}