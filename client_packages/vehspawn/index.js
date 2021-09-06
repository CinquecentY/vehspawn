require('mp-commands');
const ScaleForm = require('scaleform');

const vehicles = require('vehspawn/vehicleHashes');
var vehicleClassList = setVehicleClassList();

mp.events.addCommand("vehspawn",()=>{
    let returntype = "number";
    let scaleform = new ScaleForm('vehicle_spawn');
    scaleform.callFunction('SET_PLAYER_NAME',mp.players.local.name);
    addVehicleClass(scaleform);
    mp.events.add('render', () => {
      if(scaleform)
      {
        //disableActions();
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
          let val = scaleform.callFunctionReturn('GET_CURRENT_SELECTION',returntype);
          if(val !=-1 && val !="")
          {
            if(val <= 23)
            {
            addVehicle(scaleform,setVehicleList(val));
            scaleform.callFunction('SHOW_VEH_LIST_SCREEN');
            returntype = "string";
            }
            else
            {
              mp.events.callRemote("vehspawn_Spawn",val);
              scaleform = closeScaleform(scaleform);
            }
          }
        }
        if(mp.game.controls.isControlPressed(2,241))
        {
          scaleform.callFunction('SET_SCROLL_INPUT',0);
        }
        if(mp.game.controls.isControlPressed(2,242))
        {
          scaleform.callFunction('SET_SCROLL_INPUT',260);
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

function closeScaleform(scaleform) {
  scaleform.dispose();
  scaleform = null;
  enableActions();
  return scaleform;
}

function disableActions() {
  mp.game.controls.disableAllControlActions(0);
  mp.game.controls.setInputExclusive(2,239);
  mp.game.controls.setInputExclusive(2,240);
  mp.game.controls.setInputExclusive(0,51);
  mp.game.controls.setInputExclusive(2,237);
  mp.game.controls.setInputExclusive(2,241); // Scroll inputs don't work if disableAllControlActions(0) is enabled for some reason, if you see this message and found a fix please pm me
  mp.game.controls.setInputExclusive(2,242); // Thanxxxxxx
  mp.game.controls.setInputExclusive(2,188);
  mp.game.controls.setInputExclusive(2,187);
}

function enableActions(){
  mp.game.controls.enableAllControlActions(0);
}

function addVehicle(scaleform,vehicleList) {
  for (let i = 0; i < vehicleList.length; i++) {
    scaleform.callFunction('ADD_VEHICLE', vehicleList[i]["name"], vehicleList[i]["label"],vehicleList[i]["txd"]);
  }
}

function addVehicleClass(scaleform) {
  for (let i = 0; i < vehicleClassList.length; i++) {
    scaleform.callFunction('ADD_VEH_CLASS', vehicleClassList[i]["id"], vehicleClassList[i]["label"],vehicleClassList[i]["txd"],vehicleClassList[i]["vehname"]);
  }
}

  function getFirstVehicleFromClass(vehclass)
  {
    for (let i of vehicles){
      let hash = mp.game.joaat(i["name"]);
      if(mp.game.vehicle.getVehicleClassFromName(hash) == vehclass)
      {
        return i;
      }
    }
    return 0;
  }

  function setVehicleClassList()
  {
    var array=[];
    for (let i = 0; i < 23; i++)
    {
      let vehicle = getFirstVehicleFromClass(i)
      array.push({
        id:i,
        label:mp.game.ui.getLabelText(`VEH_CLASS_${i}`),
        txd:vehicle["txd"],
        vehname:vehicle["name"]
      });
    }
    return array;
  }
  function setVehicleList(vehclass)
  {
    var array = [];
    for (let i of vehicles){
      let hash = mp.game.joaat(i["name"]);
      if(mp.game.vehicle.getVehicleClassFromName(hash) == vehclass)
      {
        let displayName = mp.game.vehicle.getDisplayNameFromVehicleModel(hash);
        array.push({
        name: i["name"],
        label:mp.game.ui.getLabelText(displayName),
        txd:i["txd"]
        });
      }
    }
    return array;
  }