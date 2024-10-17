const BaseModel = require("./base");

//inheritance
class RoleModel extends BaseModel {
  constructor() {
    super("roles");
    this.select = {
        id: true,
        role_id: true,
    };
  }
}

module.exports = RoleModel
