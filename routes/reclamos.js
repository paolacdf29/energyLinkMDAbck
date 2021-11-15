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

router.post('/crear', function(req, res){
    let ticket = {
        id_cliente: req.session.user,
        id_empleado: null,
        id_sucursal: getSucursalbycliente(req.session.user),
        fecha_cierre:null,
        detalle: req.body.reclamo,
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
    console.log(row);
    return row[0].id_sucursal;
}

async function getReclamos(){
    let query = 'select * from reclamo';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
