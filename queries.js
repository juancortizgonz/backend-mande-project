const { request, response } = require('express')

const Pool = require('pg').Pool
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'api',
    password: 'postgres123@',
    port: 5432,
})

const getUsers = (request, response) => {
    pool.query('SELECT * FROM usuario ORDER BY id_usuario ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const getUserById = (request, response) => {
    const id_usuario = parseInt(request.params.id_usuario)

    pool.query('SELECT * FROM usuario WHERE id = $1', [id_usuario], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const createUser = (request, response) => {
    const { nombre_usuario, email_usuario, password_usuario, direccion_usuario, path_doc, telefono_usuario } = request.body

    pool.query('INSERT INTO usuario (nombre_usuario, email_usuario, password_usuario, direccion_usuario, path_doc, telefono_usuario) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *', [nombre_usuario, email_usuario, password_usuario, direccion_usuario, path_doc, telefono_usuario], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`User successfully added with ID: ${results.rows[0].id_usuario}`)
    })
}

const updateUser = (request, response) => {
    const id_usuario = parseInt(request.params.id_usuario)
    const { nombre_usuario, email_usuario, password_usuario, direccion_usuario, path_doc, telefono_usuario } = request.body

    pool.query('UPDATE usuario SET nombre_usuario = $1, email_usuario = $2, password_usuario = $3, direccion_usuario = $4, path_doc = $5, telefono_usuario = $6 WHERE id = $7', [nombre_usuario, email_usuario, password_usuario, direccion_usuario, path_doc, telefono_usuario, id_usuario], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).send(`User modified with ID: ${id_usuario}`)
    })
}

const deleteUser = (request, response) => {
    const id_usuario = parseInt(request.params.id_usuario)

    pool.query('DELETE FROM usuario WHERE id_usuario = $1', [id_usuario], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).send(`User deleted with ID: ${id_usuario}`)
    })
}


module.exports = {
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
}