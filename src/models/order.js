const BaseModel = require("./base");

//inheritance
class OrderModel extends BaseModel {
  constructor() {
    super("orders");
    this.select = {
        id: true,
        order_no: true,
        users:{
          fullname: true
        },
        cars:{
          name: true
        },
        status: true
    };
  }
}

module.exports = OrderModel
