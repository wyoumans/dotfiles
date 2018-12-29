"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const Common_1 = require("../../Common");
class Server extends Common_1.default {
    static run(useDefaults = false) {
        return __awaiter(this, void 0, void 0, function* () {
            let host = useDefaults ? '' : yield this.getInput('Should I use a specific host (Default: localhost)?');
            let port = useDefaults ? '' : yield this.getInput('Should I use a specific port (Default: 8000)?');
            this.host = host.length > 0 ? host : 'localhost';
            this.port = port.length > 0 ? port : '8000';
            // let command = `serve ${'--host=' + this.host} ${'--port=' + this.port}`
            let artisanToUse = yield this.listArtisanPaths();
            this.terminal = vscode_1.window.createTerminal('Laravel Artisan Server');
            this.terminal.show();
            this.terminal.sendText(`php "${artisanToUse}" serve ${'--host=' + this.host} ${'--port=' + this.port}`);
            this.showMessage(`The server is now running on "http://${Server.host}:${Server.port}"`);
        });
    }
    static stop() {
        return __awaiter(this, void 0, void 0, function* () {
            if (Server.terminal) {
                this.terminal.dispose();
                this.showMessage(`The server has been stopped on "http://${Server.host}:${Server.port}"`);
            }
            else {
                this.showError('There is no server currently running');
            }
        });
    }
}
exports.default = Server;
//# sourceMappingURL=Serve.js.map