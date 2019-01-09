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
const controller_1 = require("../controller");
const BaseCommand_1 = require("./BaseCommand");
class NewFileCommand extends BaseCommand_1.BaseCommand {
    constructor(controller) {
        super(controller || new controller_1.NewFileController());
    }
    execute(uri, options) {
        return __awaiter(this, void 0, void 0, function* () {
            const { relativeToRoot = false } = options || {};
            const dialogOptions = { prompt: 'File Name', relativeToRoot };
            const fileItem = yield this.controller.showDialog(dialogOptions);
            const newFileItem = yield this.controller.execute({ fileItem });
            return this.controller.openFileInEditor(newFileItem);
        });
    }
}
exports.NewFileCommand = NewFileCommand;
//# sourceMappingURL=NewFileCommand.js.map