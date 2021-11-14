const mysql = require('mysql');
const util = require('util');

/*const pool = mysql.createConnection({

    host : 'deliverymanager.capt5zrayvan.us-west-1.rds.amazonaws.com',
    user: 'admin',
    password: '12345678',
    database: 'deliverymanager'
});
*/
const pool = mysql.createConnection({

     host : 'localhost',
     user: 'root',
     password: '',
     database: 'MDA2'
});

pool.query = util.promisify(pool.query);

module.exports = pool;