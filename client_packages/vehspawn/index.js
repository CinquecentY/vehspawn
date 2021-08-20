require('mp-commands');
const ScaleForm = require('scaleform');

const vehicles = require('vehspawn/vehicleHashes');
var vehicleClassList = setVehicleClassList();
mp.events.addCommand("vehspawn",()=>{
    let scaleform = new ScaleForm('vehicle_spawn');
    scaleform.callFunction('SET_PLAYER_NAME',mp.players.local.name);
    for (let i = 0; i < vehicleClassList.length; i++) {
      scaleform.callFunction('ADD_VEH_CLASS',vehicleClassList[i][0],vehicleClassList[i][1]);
    }
    mp.events.add('render', () => {
      if(scaleform)
      {
        /*mp.game.controls.disableAllControlActions(0);
        mp.game.controls.setInputExclusive(28, 239);
        mp.game.controls.setInputExclusive(28, 240);*/
        scaleform.callFunction('SET_MOUSE_INPUT',mp.game.controls.getControlNormal(28, 239),mp.game.controls.getControlNormal(28, 240));
        scaleform.renderFullscreen();
        if(mp.game.controls.isControlPressed(0,51))
        {
          scaleform.dispose();
          scaleform = null;
        }
        if(mp.game.controls.isControlPressed(28,237))
        {
          scaleform.callFunction('SET_INPUT_EVENT',237);
        }
        if(mp.game.controls.isControlPressed(28,241))
        {
          scaleform.callFunction('SET_SCROLL_INPUT',mp.game.controls.getControlNormal(28,241))
        }
        if(mp.game.controls.isControlPressed(28,242))
        {
          scaleform.callFunction('SET_SCROLL_INPUT',mp.game.controls.getControlNormal(28,242))
        }
        
      }  
    })
  });

  function setVehicleClassList()
  {
    var array=[];
    for (let i = 0; i < 23; i++)
    {
      let vehclass = `VEH_CLASS_${i}`;
      array[i] =[vehclass,mp.game.ui.getLabelText(vehclass)];
    }
    return array;
  }