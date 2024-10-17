// req.user -> role
// role -> data access

const accessModel = require("../models/access");
const access = new accessModel();

function rbac(menuParam, accessParam) {
  return async (req, res, next) => {
    const role_id = req.user.role_id;
    if (role_id === 1) return next();

    // Contoh kalau di Query :
    // SELECT * from access a
    // Join MENU m on a.menu_id = m.id
    // WHERE a.role_id = 1 AND grant = { [$accessParam] : true } AND m.name = $menu

    const accessByRole = await access.getOne({
      where: {
        role_id,
        grant: {
          path: [accessParam],
          equals: true,
        },
        menus: {
          is: {
            name: menuParam,
          },
        },
      },
    });
    console.log(accessByRole);
    if (!accessByRole) return next(new ValidationError("Forbidden"));
    next();
  };
}

module.exports = rbac;
