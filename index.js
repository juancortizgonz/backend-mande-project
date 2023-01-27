const express = require('express')
const bodyParser = require('body-parser')
const { request, response } = require('express')
const app = express()
const port = 3000
const db = require('./queries')


app.use(bodyParser.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)

app.get('/', (request, response) => {
    response.json({ info: 'Node.js, Express, and Postgres API' })
})

app.get('/usuarios', db.getUsers)
app.get('/usuarios/:id', db.getUserById)
app.post('/usuarios', db.createUser)
app.put('/usuarios/:id', db.updateUser)
app.delete('/usuarios/:id', db.deleteUser)

app.listen(port, () => {
    console.log(`App running on port ${port}`)
})