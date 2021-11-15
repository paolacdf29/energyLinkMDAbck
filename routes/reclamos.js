var express = require('express');
var router = express.Router();
var bd = require('../bd');


router.get('/', function(req, res) {
    getReclamos()
        .then(reclamos =>{
            res.json(reclamos);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }); 
});

router.post('/crear', async function(req, res){
    if (req.session.user) {
    const uid =  req.session.user;
    let ticket = {
        id_cliente: uid,
        id_empleado: 1,
        id_sucursal: await getSucursalbycliente(uid),
        fecha_cierre:null,
        detalle: req.body.detalle,
        fecha_creac: null,
        estado: 0,
        prioridad: null
    }
        crearReclamo(ticket)
            .then(reclamo =>{
                res.json(reclamo);
            }).catch(err =>{
                res.json({ok: false, error: err});
            });
    }else{
        res.json({ok: false, error: "el usuario debe estar logeado"});
    }

});

router.get('/cliente/:id', function(req, res) {
    let userid = req.params.id;
    getReclamosByUser(userid)
        .then(reclamos =>{
            res.json(reclamos);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }); 
});

async function getReclamosByUser(id_cliente){
    let query = 'select * from reclamo where id_cliente = ?';
    let row = await bd.query(query, [id_cliente]);
    return row;

}

async function crearReclamo(reclamo){
    let query = 'insert into reclamo set ?';
    let row = await bd.query(query, [reclamo]);
    return row;
}

async function getSucursalbycliente(idCliente){
    let query = 'select id_sucursal from Cliente where id_cliente = ?';
    let row = await bd.query(query, [idCliente]);
    let sucursal = row[0].id_sucursal;
    console.log(sucursal);
    console.log(row);
    return sucursal;
}

async function getReclamos(){
    let query = 'select * from reclamo';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
