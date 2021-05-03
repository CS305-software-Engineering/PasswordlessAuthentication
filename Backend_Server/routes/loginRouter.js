const express = require('express');
const bodyParser = require('body-parser');
const cors = require('./cors');
const jwt = require('jsonwebtoken');
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
        var userId = data.userId;

        var msg = { 'Auth': true, 'username': userName, message: 'Auth done... Username sent' };
        if (sockets_connections[qr_id] != undefined || sockets_connections[qr_id] != null) {
            var platform = sockets_connections[qr_id].platform;

            const accessToken = jwt.sign({ 'username': userName, 'userId': qr_id, 'Auth': true, message: 'Auth done... Username sent' }, accessTokenSecret, { expiresIn: '20m' });
            const refreshToken = jwt.sign({ 'username': userName, 'userId': qr_id, 'Auth': true, message: 'Auth done... Username sent' }, refreshTokenSecret);

            refreshTokens[qr_id] = refreshToken;

            console.log("refresh token for :  " + qr_id + "   is :------------------------");
            console.log(refreshTokens[qr_id]);

            //date
            let date_ob = new Date();
            let date = ("0" + date_ob.getDate()).slice(-2);
            let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
            let year = date_ob.getFullYear();
            let hours = date_ob.getHours();
            let minutes = date_ob.getMinutes();
            let seconds = date_ob.getSeconds();

            var loginDate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;

            console.log('username received: ' + userName);
            console.log('platform: ' + platform);

            await db.collection('userInfo').doc(userId).update({
                'Status': 'active',
                'Login Time': loginDate,
                'Logout Time': '-',
                'platform': platform
            }).then(function (docRef) {
                console.log('Doc added: ');
            })
                .catch(function (error) {
                    console.error('Error adding document: ' + error);
                });


            var msg = { 'Auth': true, 'username': userName, 'userId': userId, 'token': accessToken };


            sockets_connections[qr_id].auth = true;  //new
            sockets_connections[qr_id].userId = userId; //new
            sockets_connections[qr_id].send(JSON.stringify(msg), { mask: false });
            mapId[qr_id] = userId;

            res.status(201).send(msg);
        }
        else {
            res.status(400).send('No information is found with requested data');
        }


    });

module.exports = loginRouter;