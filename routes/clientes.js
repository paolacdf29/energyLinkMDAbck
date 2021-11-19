'USE STRICT'
var express = require('express');
var router = express.Router();
var bd = require('../bd');

/* GET users listing. */
router.get('/', function(req, res) {
    if (req.session.rol = 2 ){
        getClientes()
            .then(clientes =>{
                res.json(clientes);
            }).catch(err =>{
                res.json({ok: false, error: err});
            }) 
    }else{
        res.json({ok: false, error: 'no tiene permisos'});
    }
});

router.post('/login', async function(req, res){
    let cliente = req.body.usuario;
    let clave = req.body.contrasena;

    let user = await Logger(cliente, clave);
    if (user.length > 0){
        const uid = user[0].id_cliente;
        req.session.user = uid;
        req.session.rol = 1; // 1 clientes, 2 empleados
        res.json({ok: true, user});
    }else{
        res.json({ok: false, error: 'usuario y/o contraseña invalidos'});
    }; 
});

router.get('/logout', async(req,res,next)=> {
    req.session.destroy(); // destruye la sesion DEL 
    res.json({ok: true});
});

router.post('/registro', function(req, res){

    let usuario = {
        id_sucursal: req.body.id_sucursal,
        cuit: req.body.cuit,
        razon_soc: req.body.razon_soc,
        contacto: req.body.contacto,
        telefono: req.body.telefono,
        email: req.body.email,
        usuario: req.body.usuario,
        contrasena: req.body.usuario 
    };
    registar(usuario)
    .then(cliente =>{
        res.json({ok: true, cliente});
    }).catch(err => {
        res.json({ok: false, error: err});
    });
  
})

router.put('/recuperar', function(req, res){
    let usuario = req.body.usuario;
    recuperarClave(usuario)
        .then(cliente =>{
            let respuesta = 'Se ha enviado un mail al correo ' + cliente[0].email + ' con su nueva clave';
            res.json({ok: true, msj: respuesta});
        }).catch(err => {
            res.json({ok: false, error: err});
        });
})

async function registar(usuario){
    let query = 'insert into Cliente set ?';
    let row = await bd.query(query, [usuario]);
    return row;
}

async function Logger(usario, clave){
    let query = 'select * from cliente where usuario = ? and contrasena = ?';
    let rows = await bd.query(query, [usario, clave]);
    return rows;
};

async function getClientes(){
    let query = 'select * from Cliente';
    let row = await bd.query(query);
    return row;
};


async function recuperarClave(usuario){
    let query = 'select email from Cliente where usuario = ?';
    let row = await bd.query(query, [usuario]);
    return row;
}

module.exports = router;
