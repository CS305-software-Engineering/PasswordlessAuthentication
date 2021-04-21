const express = require('express');
const bodyParser = require('body-parser');
const cors = require('./cors');
const jwt = require('jsonwebtoken');
//const db = require('./database.js');
const auth = require('../auth.js');
const config = require('../config.js');

const accessTokenSecret = config.accessTokenSecret;
const refreshTokenSecret = config.refreshTokenSecret;


const loginRouter = express.Router();

loginRouter.use(bodyParser.json());



loginRouter.route('/')
    .post(async function (req, res, next) {
        const data = req.body;
        console.log("Recived login data: " + JSON.stringify(data));
        var qr_id = data.qr_id;
        var userName = data.username;

        var msg = { 'Auth': true, 'username': userName, message: 'Auth done... Username sent' };
        //console.log(sockets_connections[qr_id]);
        if (sockets_connections[qr_id] != undefined || sockets_connections[qr_id] != null) {

            const accessToken = jwt.sign({ 'username': userName, 'Auth': true, message: 'Auth done... Username sent' }, accessTokenSecret, { expiresIn: '20m' });
            const refreshToken = jwt.sign({ 'username': userName, 'Auth': true, message: 'Auth done... Username sent' }, refreshTokenSecret);

            refreshTokens[userName] = refreshToken;

            //date
            let date_ob = new Date();

            // current date
            // adjust 0 before single digit date
            let date = ("0" + date_ob.getDate()).slice(-2);

            // current month
            let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);

            // current year
            let year = date_ob.getFullYear();

            // current hours
            let hours = date_ob.getHours();

            // current minutes
            let minutes = date_ob.getMinutes();

            // current seconds
            let seconds = date_ob.getSeconds();

            var loginDate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;

            console.log('username received: ' + userName);
            //const docRef = db.collection('userInfo').doc('alovelace');
            await db.collection('userInfo').doc(userName).set({
                'name': userName,
                'Status': 'active',
                'Login Time': loginDate,
                'Logout Time': '-'
            }).then(function (docRef) {
                console.log('Doc added: ');
            })
                .catch(function (error) {
                    console.error('Error adding document: ' + error);
                });

            // const setinfo = await userRef.where('name', '==', userName).set({
            //     'name': userName,
            //     'Status': 'active',
            //     'Login Time': loginDate
            // }).then(function (docRef) {
            //     current_doc = docRef.data().curr_doc;
            //     console.log('Doc added: ' + current_doc);
            // })
            //     .catch(function (error) {
            //         console.error('Error adding document: ' + error);
            //     });

            // await docRef.set({
            //     first: 'Ada',
            //     last: 'Lovelace',
            //     born: 1815
            // });

            var msg = { 'Auth': true, 'username': userName, 'token': accessToken };
            //console.log("Before " + Object.size(clients));
            sockets_connections[qr_id].send(JSON.stringify(msg), { mask: false });
            //console.log("inside iff");
            delete sockets_connections[qr_id];
            //console.log("After " + Object.size(clients));

            // res.json({
            //     accessToken,
            //     refreshToken
            // });


            res.status(201).send(msg);
        }
        else {
            res.status(400).send('No information is found with requested data');
        }
        res.status(400).send('No information is found with requested data');
        //res.status(201).send(JSON.stringify(msg));
    });

module.exports = loginRouter;