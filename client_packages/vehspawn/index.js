require('mp-commands');
const ScaleForm = require('scaleform');

const vehicles = require('vehspawn/vehicleHashes');
var vehicleClassList = setVehicleClassList();

mp.events.addCommand("vehspawn",()=>{
    let scaleform = new ScaleForm('vehicle_spawn');
    scaleform.callFunction('SET_PLAYER_NAME',mp.players.local.name);
    addVehicleClass(scaleform);
    mp.events.add('render', () => {
      if(scaleform)
      {
        disableActions();
        scaleform.callFunction('SET_MOUSE_INPUT',mp.game.controls.getControlNormal(2, 239),mp.game.controls.getControlNormal(2, 240));
        scaleform.renderFullscreen();
        if(mp.game.controls.isControlPressed(0,51))
        {
          scaleform.dispose();
          scaleform = null;
        }
        if(mp.game.controls.isControlJustPressed(2,237))
        {
          scaleform.callFunction('SET_INPUT_EVENT',237);
          let val = scaleform.callFunctionReturn('GET_CURRENT_SELECTION',"number");
          mp.gui.chat.push(val.toString());
          if(val !=-1)
          {
            if(val <= 23)
            {
            addVehicle(scaleform,setVehicleList(val));
            scaleform.callFunction('SHOW_VEH_LIST_SCREEN');
            }
            else
            {
              mp.events.callRemote("vehspawn_Spawn",val);
              scaleform.dispose();
              scaleform = null;
              enableActions();
            }
          }
        }
        if(mp.game.controls.isControlPressed(2,241))
        {
          scaleform.callFunction('SET_SCROLL_INPUT',mp.game.controls.getControlNormal(2,241))
        }
        if(mp.game.controls.isControlPressed(2,242))
        {
          scaleform.callFunction('SET_SCROLL_INPUT',-mp.game.controls.getControlNormal(2,242))
        }
        if(mp.game.controls.isControlPressed(2,188))
        {
          scaleform.callFunction('SET_INPUT_EVENT',188);
        }
        if(mp.game.controls.isControlPressed(2,187))
        {
          scaleform.callFunction('SET_INPUT_EVENT',187);
        }
      }  
    })
  });

function disableActions() {
  mp.game.controls.disableAllControlActions(0);
  mp.game.controls.setInputExclusive(2,239);
  mp.game.controls.setInputExclusive(2,240);
  mp.game.controls.setInputExclusive(2,237);
  mp.game.controls.setInputExclusive(2,242);
  mp.game.controls.setInputExclusive(2,188);
  mp.game.controls.setInputExclusive(2,187);
  mp.game.controls.setInputExclusive(2,242);
  mp.game.controls.setInputExclusive(2,242);
}

function enableActions(){
  mp.game.controls.enableAllControlActions(0);
}

function addVehicle(scaleform,vehicleList) {
  for (let i = 0; i < vehicleList.length; i++) {
    scaleform.callFunction('ADD_VEHICLE', vehicleList[i][0], vehicleList[i][1]);
  }
}

function addVehicleClass(scaleform) {
  for (let i = 0; i < vehicleClassList.length; i++) {
    scaleform.callFunction('ADD_VEH_CLASS', vehicleClassList[i][0], vehicleClassList[i][1]);
  }
}

  function setVehicleClassList()
  {
    var array=[];
    for (let i = 0; i < 23; i++)
    {
      mp.gui.chat.push(i);
      array.push([i,mp.game.ui.getLabelText(`VEH_CLASS_${i}`)]);
    }
    return array;
  }
  function setVehicleList(vehclass)
  {
    var array = [];
    for (let i in vehicles){
      if(mp.game.vehicle.getVehicleClassFromName(vehicles[i]) == vehclass)
      {
        let displayName = mp.game.vehicle.getDisplayNameFromVehicleModel(vehicles[i]);
        array.push([vehicles[i],mp.game.ui.getLabelText(displayName)]);
      }
    }
    return array;
  }