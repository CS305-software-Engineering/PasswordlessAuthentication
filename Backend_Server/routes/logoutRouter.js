const express = require('express');
const bodyParser = require('body-parser');
const cors = require('./cors');
const jwt = require('jsonwebtoken');
const auth = require('../auth.js');
const config = require('../config.js');
//const db = require('./database.js');

const accessTokenSecret = config.accessTokenSecret;
const refreshTokenSecret = config.refreshTokenSecret;

const logoutRouter = express.Router();

logoutRouter.use(bodyParser.json());


logoutRouter.route('/')
    .post(async (req, res) => {
        const data = req.body;
        console.log('name and refreshTokens check:  ');
        var temp = data.userId.toString();
        console.log(temp);
        var temp1 = mapId[temp];
        delete mapId[temp];
        for (var i in mapId) {
            if (mapId[i] == temp) {
                console.log("mapId[i]:  ");
                console.log('qr__id:  ');
                console.log(i);
                console.log('before delete :  ');
                console.log(refreshTokens[i]);
                console.log('userId :  ');
                console.log(mapId[i]);
                delete refreshTokens[i];
                delete mapId[i];
                console.log('after delete');
                console.log(refreshTokens[i]);

            }
        }

        let date_ob = new Date();

        let date = ("0" + date_ob.getDate()).slice(-2);
        let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
        let year = date_ob.getFullYear();
        let hours = date_ob.getHours();
        let minutes = date_ob.getMinutes();
        let seconds = date_ob.getSeconds();

        var loginDate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;

        await db.collection('userInfo').doc(temp1).update({
            'Status': 'inactive',
            'Login Time': '-',
            'Logout Time': loginDate
        }).then(function (docRef) {
            console.log('Doc added: ');
        })
            .catch(function (error) {
                console.error('Error adding document: ' + error);
            });
        res.send("Logout successful");
    });

logoutRouter.route('/remote')
    .post(async (req, res) => {
        const data = req.body;
        console.log('name and refreshTokens check:  ');
        var temp = data.userId.toString();
        console.log(temp);
        var temp1 = temp;

        for (var i in mapId) {
            if (mapId[i] == temp) {
                console.log("mapId[i]:  ");
                console.log('qr__id:  ');
                console.log(i);
                console.log('before delete :  ');
                console.log(refreshTokens[i]);
                console.log('userId :  ');
                console.log(mapId[i]);
                delete refreshTokens[i];
                delete mapId[i];
                console.log('after delete');
                console.log(refreshTokens[i]);
            }
        }

        let date_ob = new Date();

        let date = ("0" + date_ob.getDate()).slice(-2);
        let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
        let year = date_ob.getFullYear();
        let hours = date_ob.getHours();
        let minutes = date_ob.getMinutes();
        let seconds = date_ob.getSeconds();

        var loginDate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;

        await db.collection('userInfo').doc(temp1).update({
            'Status': 'inactive',
            'Login Time': '-',
            'Logout Time': loginDate
        }).then(function (docRef) {
            console.log('Doc added: ');
        })
            .catch(function (error) {
                console.error('Error adding document: ' + error);
            });
        res.send("Logout successful");
    });

logoutRouter.route('/ws')
    .post(async (req, res) => {
        const data = req.body;
        console.log("data received...");
        console.log(data);
        var temp = data.userId;
        console.log("userId:  ");
        console.log(temp);

        var temp1 = mapId[temp];
        console.log('userId:  ' + temp1);
        delete refreshTokens[temp];
        delete mapId[temp];


        let date_ob = new Date();
        let date = ("0" + date_ob.getDate()).slice(-2);
        let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
        let year = date_ob.getFullYear();
        let hours = date_ob.getHours();
        let minutes = date_ob.getMinutes();
        let seconds = date_ob.getSeconds();
        var loginDate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;

        await db.collection('userInfo').doc(temp1).update({
            'Status': 'inactive',
            'Login Time': '-',
            'Logout Time': loginDate
        }).then(function (docRef) {

            console.log('Doc added: ');
        })
            .catch(function (error) {
                console.error('Error adding document: ' + error);
            });
        delete sockets_connections[temp];
        res.send("Logout successful");
    });

logoutRouter.route('/ws/remote')
    .post(async (req, res) => {
        const data = req.body;
        console.log("data received...");
        console.log(data);
        var temp = data.userId;
        console.log("userId:  ");
        console.log(temp);

        for (var i in mapId) {
            console.log("row " + i);
            if (mapId[i] == temp) {
                console.log("mapId[i]:  ");
                console.log(mapId[i]);
                console.log("socket----id:   " + i);
                // delete refreshTokens[i];
                // delete mapId[i];
                sockets_connections[i].send(JSON.stringify({ 'message': "logout" }), { mask: false });
                break;
            }
        }

        res.send("Logout successful");
    });

logoutRouter.route('/check')
    .post(async (req, res) => {
        const data = req.body;
        console.log('name and refreshTokens check:  ');
        var temp = data.username.toString();
        console.log("qrid id----------:");
        console.log(temp);
        var temp1 = mapId[temp];
        console.log(refreshTokens[temp]);

        if (refreshTokens[temp]) {
            res.send({ msg: "Logged in" });
            console.log('inside 1');
        }

        else {
            res.send({ msg: "Logged out" });
            console.log('inside 2');

        }
    });



module.exports = logoutRouter;