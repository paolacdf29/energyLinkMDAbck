var express = require('express');
var router = express.Router();
var bd = require('../bd');

/* GET users listing. */
router.get('/', function(req, res, next) {
    getClientes()
        .then(clientes =>{
            res.json(clientes);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }) 
    //res.send('Devuelve un cliente');
});

router.get('/otros', function(req, res, next) {
    res.send('Devuelve otro cliente');
});


async function getClientes(){
    let query = 'select * from Cliente';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
