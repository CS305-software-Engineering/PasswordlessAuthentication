const express = require('express');
const bodyParser = require('body-parser');
const cors = require('./cors');
const jwt = require('jsonwebtoken');
const auth = require('../auth.js');
const config = require('../config.js');

const accessTokenSecret = config.accessTokenSecret;
const refreshTokenSecret = config.refreshTokenSecret;

const msgRouter = express.Router();

msgRouter.use(bodyParser.json());


msgRouter.route('/')
    .post(async (req, res) => {
        const data = req.body;
        console.log("data received...");
        console.log(data);
        var temp = data.userId;
        console.log("userId:  ");
        console.log(temp);
        var temp1 = mapId[temp];
        console.log('userId:  ' + temp1);
        await db.collection('userInfo').doc(temp1).get()
            .then(function (docRef) {
                console.log('Message doc received: ');
                console.log(docRef.data());
                sockets_connections[temp].send(JSON.stringify({ 'message': "messages", 'msgs': docRef.data().messages }), { mask: false });
                res.send(docRef.data().messages);
            })
            .catch(function (error) {
                console.error('Error adding document: ' + error);
                res.send("Error receiving messages");
            });

    });

msgRouter.route('/tok')
    .post(async (req, res) => {
        const data = req.body;
        console.log('name and refreshTokens check:  ');
        var temp = data.userId.toString();
        console.log(temp);
        var temp1 = mapId[temp];
        console.log('userId:  ' + temp1);
        await db.collection('userInfo').doc(temp1).get()
            .then(function (docRef) {
                console.log('Message doc received: ');
                console.log(docRef.data());
                res.send(docRef.data().messages);
            })
            .catch(function (error) {
                console.error('Error adding document: ' + error);
                res.send("Error receiving messages");
            });

    });


module.exports = msgRouter;