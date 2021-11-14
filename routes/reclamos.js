var express = require('express');
var router = express.Router();
var bd = require('../bd');

/* GET users listing. */
router.get('/', function(req, res, next) {
    getReclamos()
        .then(reclamos =>{
            res.json(reclamos);
        }).catch(err =>{
            res.json({ok: false, error: err});
        }) 
    //res.send('Devuelve un cliente');
});

router.get('/otros', function(req, res, next) {
    res.send('Devuelve otro reclamo');
});


async function getReclamos(){
    let query = 'select * from reclamo';
    let row = await bd.query(query);
    return row
};
  

module.exports = router;
