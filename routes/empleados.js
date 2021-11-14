var express = require('express');
var router = express.Router();
var bd = require('../bd');

/* GET users listing. */
router.get('/', function(req, res, next) {
    getEmpleados()
        .then(empleados =>{
            res.json(empleados);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }) 
    //res.send('Devuelve un cliente');
});

router.post('/login', async function(req, res){
    let cliente = req.body.usuario;
    let clave = req.body.contrasena;

    let user = await Logger(cliente, clave);
    if (user.length > 0){
        const id = user[0].id_client;
        req.session.user = id;
        req.session.rol = 2; // 1 clientes, 2 empleados
        res.json(user);
    }else{
        res.json({ok: false, error: 'usuario y/o contraseña invalidos'});
    }; 
});

router.get('/logout', async(req,res,next)=> {
    req.session.destroy(); // destruye la sesion DEL 
    res.json({ok: true});
});

async function Logger(usario, clave){
    let query = 'select * from empleado where usuario = ? and contrasena = ?';
    let rows = await bd.query(query, [usario, clave]);
    return rows;
};

async function getEmpleados(){
    let query = 'select * from empleado';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
