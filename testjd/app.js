// app.js
const http = require('http');
const express = require('express');
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());

const data = []; // Array para armazenar os dados cadastrados em memória

app.post('/cadastro', (req, res) => {
  const newData = req.body;
  data.push(newData);
  res.status(201).json({ message: 'Cadastro realizado com sucesso', data: newData });
});

const server = http.createServer(app);

const port = process.env.PORT || 3000;

server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
