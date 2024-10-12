import { pool } from "../db.js";
import { decrypt, encrypt } from "../funciones/cryptoPass.js";
import {createTransport} from "nodemailer";
import { generate } from "generate-password";
import { EMAIL, EMAIL_PASS} from "../config.js";

let transporter = createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true, // true for 465, false for other ports 587
  auth: {
    user: EMAIL,
    pass: EMAIL_PASS,
  },
});

export const createUsuario = async (req, res) => {
  try {
    const {
      nombre,
      apellido,
      numero_doc,
      direccion,
      telefono,
      email,
      password
    } = req.body;

    const cryptPass = encrypt(password);

    let query = "INSERT INTO usuarios(nombre, apellido, numero_doc, direccion, telefono, email, password, activo, idrol) VALUES(?,?,?,?,?,?,?,1,1)";
    let params = [nombre,
                  apellido,
                  numero_doc,
                  direccion,
                  telefono,
                  email,
                  cryptPass];
    const [rows] = await pool.query(query, params); 
    res.status(200).json({ data: rows.insertId, message: 'OK' });

  } catch (error) {
    console.log(error);
    let mensaje = "Ocurrio un error";
    if(error?.code == 'ER_DUP_ENTRY'){
      mensaje = 'El correo ya existe'
    }
    if(error?.code == 'ER_BAD_NULL_ERROR'){
      mensaje = 'Campos obligatorios'
    }

    return res.status(404).json({ message: mensaje });
  }
};

export const getUsuario = async (req, res) => {
  try {
    const { id } = req.body;
    const [rows] = await pool.query("SELECT nombre, apellido, numero_doc, direccion, telefono, email FROM usuarios WHERE id = ?", [id]);
    if (rows.length <= 0) {
      return res.status(404).json({ message: "No se encuentra el Usuario" });
    }
    res.status(200).json({ data: rows[0], message: 'OK' });
  } catch (error) {
    console.log('error get usuario: ', error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const updateUsuario = async (req, res) => {
  try {
    const { id, nombre, apellido, numero_doc, direccion, telefono } = req.body;

    let query = `UPDATE usuarios SET
                 nombre = ?,
                 apellido = ?,
                 numero_doc = ?,
                 direccion = ?,
                 telefono = ?,
                 fecha_actualizacion = now()
                 WHERE id = ?`;
    let params = [nombre, apellido, numero_doc, direccion, telefono, id];
    const [result] = await pool.query(query, params);

    if (result.affectedRows === 0)
      return res.status(404).json({ message: "Usuario no encontrado" });

    const [rows] = await pool.query(
      "SELECT nombre, apellido, numero_doc, direccion, telefono FROM Usuarios WHERE id = ?",
      [id]
    );
    res.status(200).json({ data: rows[0], message: "OK" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const loginUsuario = async (req, res) => {
  try {
    const { email, password } = req.body;

    let query = `SELECT 
                      u.id,
                      u.nombre,
                      u.apellido,
                      u.numero_doc,
                      u.direccion,
                      u.telefono,
                      u.email,
                      u.password,
                      u.activo,
                      u.idrol,
                      r.nombre nombre_rol
                  FROM usuarios u
                  inner join rol r on r.id = u.idrol
                  WHERE u.email = '${email}';`
    
    const [rows] = await pool.query(query);

    if (rows.length <= 0) {
      return res.status(404).json({ message: "No se encuentra el Usuario" });
    }

    let usuario = rows[0];

    if (usuario.activo == 0) {
      return res.status(404).json({ message: "Usuario bloqueado, consulte con el administrador" });
    }

    const validarPasswor = decrypt(usuario.password, password)

    if (!validarPasswor) {
      return res.status(404).json({ message: "Contraseña incorrecta" });
    }

    const data = {
      id: usuario.id,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      numero_doc: usuario.numero_doc,
      direccion: usuario.direccion,
      telefono: usuario.telefono,
      email: usuario.email,
      idrol: usuario.idrol,
      nombreRol: usuario.nombre_rol,
    };

    res.status(200).json({ data, message: "OK" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const restablecerPassword = async (req, res) => {
  try {
    const { email } = req.body;

    const query = `SELECT
                    id
                  FROM usuarios u
                  WHERE email = '${email}';`
    
    const [rows] = await pool.query(query);

    if (rows.length <= 0) {
      return res.status(404).json({ message: "El email ingresado no se encuentra registrado" });
    }
    
    let usuarioId = rows[0];
    var password = generate({length: 10, numbers: true});

    const cryptPass = encrypt(password);

    let queryUpdate = `UPDATE usuarios SET
                        password = '${cryptPass}',
                        fecha_actualizacion = now()
                        WHERE id = '${usuarioId.id}';`;

    await pool.query(queryUpdate);

    var mailOptions = {
      from: process.env.EMAIL,
      to: email,
      subject: "Contraseña de ingreso",
      text: `Su nueva contraseña de ingreso es: ${password}`,
    };

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log("error en el envio de email...");
        console.log(error);
        res.status(404).json({ message: "Fallo el servicio para restablecer contraseña" });
      } else {
        console.log("Email sent: " + info.response);
        res.status(200).json({ message: "OK" });
      }
    });

  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const listaEmpleados = async (req, res) => {
  try {
    const [rows] = await pool.query(`SELECT u.id, u.nombre, u.apellido, u.numero_doc, u.direccion, u.telefono, u.email, lower(r.nombre) rol, u.fecha_actualizacion FROM usuarios u
                                      inner join rol r on r.id = u.idrol
                                      WHERE u.idrol in (2, 3) order by u.fecha_actualizacion desc`);
    if (rows.length <= 0) {
      return res.status(404).json({ message: "No hay empleados" });
    }
    res.status(200).json({ data: rows, message: 'OK' });
  } catch (error) {
    console.log('error get usuario: ', error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const createEmpleado = async (req, res) => {
  try {
    const {
      nombre,
      apellido,
      numero_doc,
      direccion,
      telefono,
      email,
      password,
      idrol
    } = req.body;

    const cryptPass = encrypt(password);

    let query = "INSERT INTO usuarios(nombre, apellido, numero_doc, direccion, telefono, email, password, activo, idrol) VALUES(?,?,?,?,?,?,?,1,?)";
    let params = [nombre,
                  apellido,
                  numero_doc,
                  direccion,
                  telefono,
                  email,
                  cryptPass,
                  idrol
                ];
    const [rows] = await pool.query(query, params); 
    res.status(200).json({ data: rows.insertId, message: 'OK' });

  } catch (error) {
    console.log(error);
    let mensaje = "Ocurrio un error";
    if(error?.code == 'ER_DUP_ENTRY'){
      mensaje = 'El correo ya existe'
    }
    if(error?.code == 'ER_BAD_NULL_ERROR'){
      mensaje = 'Campos obligatorios'
    }

    return res.status(404).json({ message: mensaje });
  }
};

export const getEmpleado = async (req, res) => {
  try {
    const { id } = req.body;
    const [rows] = await pool.query("SELECT nombre, apellido, numero_doc, direccion, telefono, email, activo, idrol FROM usuarios WHERE id = ?", [id]);
    if (rows.length <= 0) {
      return res.status(404).json({ message: "No se encuentra el Empleado" });
    }
    res.status(200).json({ data: rows[0], message: 'OK' });
  } catch (error) {
    console.log('error get employee: ', error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const updateEmpleado = async (req, res) => {
  try {
    const { id, nombre, apellido, numero_doc, direccion, telefono, email, activo, idrol } = req.body;


    let query = `UPDATE usuarios SET
                 nombre = '${nombre}',
                 apellido = '${apellido}',
                 numero_doc = '${numero_doc}',
                 direccion = '${direccion}',
                 telefono = '${telefono}',
                 email = '${email}',
                 activo = ${activo},
                 idrol = ${idrol},
                 fecha_actualizacion = now()
                 WHERE id = ${id}`;

    const [result] = await pool.query(query);

    if (result.affectedRows === 0){
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    const [rows] = await pool.query(
      "SELECT nombre, apellido, numero_doc, direccion, telefono FROM Usuarios WHERE id = ?",
      [id]
    );
    res.status(200).json({ data: rows[0], message: "OK" });
  } catch (error) {
    console.log(error);
    let mensaje = "Ocurrio un error";
    if(error?.code == 'ER_DUP_ENTRY'){
      mensaje = 'El correo ya existe'
    }
    if(error?.code == 'ER_BAD_NULL_ERROR'){
      mensaje = 'Campos obligatorios'
    }
    return res.status(404).json({ message: mensaje });
  }
};

export const actualizarPassword = async (req, res) => {
  try {
    const { iduser, passwordOld, password } = req.body;

    const query = `SELECT
                    id,
                    password
                  FROM usuarios u
                  WHERE id = '${iduser}';`
    
    const [rows] = await pool.query(query);

    if (rows.length <= 0) {
      return res.status(404).json({ message: "No se encuentra el usuario, intente nuevamente" });
    }
    
    let usuario = rows[0];

    const validarPasswor = decrypt(usuario.password, passwordOld);
    
    if (!validarPasswor) {
      return res.status(404).json({ message: "Contraseña incorrecta" });
    }

    const cryptPass = encrypt(password);

    let queryUpdate = `UPDATE usuarios SET
                        password = '${cryptPass}',
                        fecha_actualizacion = now()
                        WHERE id = '${usuario.id}';`;

    await pool.query(queryUpdate);

    res.status(200).json({ message: "OK" });

  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};