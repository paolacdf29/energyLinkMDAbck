var express = require('express');
var router = express.Router();
var bd = require('../bd');

/* GET users listing. */
router.get('/', function(req, res, next) {
    getClientes()
        .then(empleados =>{
            res.json(empleados);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }) 
    //res.send('Devuelve un cliente');
});

router.get('/otros', function(req, res, next) {
    res.send('Devuelve otro empleado');
});


async function getEmpleados(){
    let query = 'select * from empleado';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
