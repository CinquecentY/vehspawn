class BasicScaleform {
    constructor(scaleformName) {
        this.handle = mp.game.graphics.requestScaleformMovie(scaleformName);
        while (!mp.game.graphics.hasScaleformMovieLoaded(this.handle)) mp.game.wait(0);
    }

    callFunction(functionName, ...args) {
        mp.game.graphics.pushScaleformMovieFunction(this.handle, functionName);

        args.forEach(arg => {
            switch(typeof arg) {
                case "string": {
                    mp.game.graphics.pushScaleformMovieFunctionParameterString(arg);
                    break;
                }

                case "boolean": {
                    mp.game.graphics.pushScaleformMovieFunctionParameterBool(arg);
                    break;
                }

                case "number": {
                    if(Number(arg) === arg && arg % 1 !== 0) {
                        mp.game.graphics.pushScaleformMovieFunctionParameterFloat(arg);
                    } else {
                        mp.game.graphics.pushScaleformMovieFunctionParameterInt(arg);
                    }
                }
            }
        });

        mp.game.graphics.popScaleformMovieFunctionVoid();
    }

    callFunctionReturn(functionName,type, ...args) {
        mp.game.graphics.pushScaleformMovieFunction(this.handle, functionName);

        args.forEach(arg => {
            switch(typeof arg) {
                case "string": {
                    mp.game.graphics.pushScaleformMovieFunctionParameterString(arg);
                    break;
                }

                case "boolean": {
                    mp.game.graphics.pushScaleformMovieFunctionParameterBool(arg);
                    break;
                }

                case "number": {
                    if(Number(arg) === arg && arg % 1 !== 0) {
                        mp.game.graphics.pushScaleformMovieFunctionParameterFloat(arg);
                    } else {
                        mp.game.graphics.pushScaleformMovieFunctionParameterInt(arg);
                    }
                }
            }
        });
        let methodReturn = mp.game.graphics.popScaleformMovieFunction();
        while(!mp.game.invoke('0x768FF8961BA904D6',methodReturn)) mp.game.wait(0);
        switch (type) {
            case "string":
                return mp.game.graphics.sittingTv(methodReturn);
            case "boolean":
                return mp.game.invoke('0xD80A80346A45D761',methodReturn);
            case "number":
                return mp.game.invoke('0x2DE7EFA66B906036',methodReturn);
            default:
                return "nonce";
        }
            /*if(mp.game.graphics.sittingTv(methodReturn) != "")
                return mp.game.graphics.sittingTv(methodReturn);
            if(typeof mp.game.invoke('0xD80A80346A45D761',methodReturn) == "boolean")
                return mp.game.invoke('0xD80A80346A45D761',methodReturn);
            if(typeof mp.game.invoke('0x2DE7EFA66B906036',methodReturn) == "number")
                return mp.game.invoke('0x2DE7EFA66B906036',methodReturn);
            else
                return "nonce";*/
    }

    renderFullscreen() {
        mp.game.graphics.drawScaleformMovieFullscreen(this.handle, 255, 255, 255, 255, false);
    }

    dispose() {
        mp.game.graphics.setScaleformMovieAsNoLongerNeeded(this.handle);
    }
}

exports = BasicScaleform;