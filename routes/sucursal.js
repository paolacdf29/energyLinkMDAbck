var express = require('express');
var router = express.Router();
var bd = require('../bd');

/* GET users listing. */
router.get('/', function(req, res, next) {
    getSucursal()
        .then(sucursal =>{
            res.json(sucursal);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }) 
    //res.send('Devuelve un cliente');
});

router.get('/otros', function(req, res, next) {
    res.send('Devuelve otra sucursal');
});


async function getSucursal(){
    let query = 'select * from sucursal';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
