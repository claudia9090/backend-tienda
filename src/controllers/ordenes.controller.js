import { STRIPE_KEY } from "../config.js";
import { pool } from "../db.js";
import { generate } from "generate-password";
import Stripe from "stripe";

const stripe = new Stripe(STRIPE_KEY);

export const createOrden = async (req, res) => {
  try {
    const { idusuario, idproducto} = req.body;

    // validacion si el usuario ya tiene una orden asociada
    const [rows] = await pool.query(`select max(id) idorden from orden where idstatus = 1 and idusuario = ${idusuario}`);
    
    let idorden = rows[0].idorden;

    if(!idorden){
      // crear orden
      const [insertOrden] = await pool.query(`INSERT INTO orden(idusuario, idstatus, activo) VALUES(${idusuario}, 1, 1)`);
      idorden = insertOrden.insertId
    }

    let query = "INSERT INTO detalles_orden(idorden, idproducto, cantidad) VALUES(?,?,?)";
    let params = [idorden, idproducto, 1];
    await pool.query(query, params);

    const [cantidadP] = await pool.query(`select ifnull(count(*), 0) cantidadProductos from detalles_orden where idorden = ${idorden}`);
    
    let cantidadProductos = cantidadP[0].cantidadProductos

    res.status(200).json({ data: {idorden, cantidadProductos}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const cantidadProductosCarrito = async (req, res) => {
  try {
    const { idusuario} = req.body;

    // validacion si el usuario ya tiene una orden asociada
    const [rows] = await pool.query(`select ifnull(max(id), 0) idorden from orden where idstatus = 1 and idusuario = ${idusuario}`);
    
    let idorden = rows[0].idorden;

    const [cantidadP] = await pool.query(`select ifnull(count(*), 0) cantidadProductos from detalles_orden where idorden = ${idorden}`);
    
    let cantidadProductos = cantidadP[0].cantidadProductos

    res.status(200).json({ data: {idorden, cantidadProductos}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const productosCarrito = async (req, res) => {
  try {
    const { idusuario} = req.body;

    // validacion si el usuario ya tiene una orden asociada
    const [rows] = await pool.query(`select ifnull(max(id), 0) idorden from orden where idstatus = 1 and idusuario = ${idusuario}`);
    
    let idorden = rows[0].idorden;

    const [productosOrden] = await pool.query(` select
                                                det.id id_detalle_orden,
                                                det.idorden,
                                                o.total totalOrden, p.*
                                                from detalles_orden det
                                                inner join orden o on o.id = det.idorden
                                                inner join productos p on p.id = det.idproducto
                                                where idorden =  ${idorden}`);

    res.status(200).json({ data: productosOrden, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const eliminarProductoCarrito = async (req, res) => {
  try {
    const { idorden, id_detalle_orden} = req.body;

    const [row] = await pool.query(`DELETE FROM detalles_orden WHERE id = ${id_detalle_orden}`);

    const [cantidadP] = await pool.query(`select ifnull(count(*), 0) cantidadProductos from detalles_orden where idorden = ${idorden}`);
    
    let cantidadProductos = cantidadP[0].cantidadProductos

    res.status(200).json({ data: { cantidadProductos}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};


export const pagarOrden = async (req, res) => {
  try {
    const { idusuario} = req.body;

    // validacion si el usuario ya tiene una orden asociada
    const [rows] = await pool.query(`select ifnull(max(id), 0) idorden from orden where idstatus = 1 and idusuario = ${idusuario}`);
    
    let idorden = rows[0].idorden;

    let comprobante = generate({length: 15, numbers: true});

    const [pago] = await pool.query(`UPDATE orden SET idstatus = 3, numero_comprobante = '${comprobante}', fecha_actualizacion = now() WHERE id = ${idorden}`);

    res.status(200).json({ data: {pago}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const createCheckoutSession = async (req, res) => {
  try {
   
   const { line_items} = req.body;
   const session = await stripe.checkout.sessions.create({
      line_items: [
        {
          price_data:
          {
            product_data: {
              name: 'Laptop',
              description: 'Gaming Laptop',
            },
            currency: 'usd',
            unit_amount: 200000
          },
          quantity: 1
        },
        {
          price_data:
          {
            product_data: {
              name: 'Tv',
              description: 'Samsumg NEO QLED 8k'
            },
            currency: 'usd',
            unit_amount: 47880000
          },
          quantity: 1
        }
      ],
      mode: 'payment',
      success_url: 'http://192.168.1.4:3000/api/success',
      cancel_url: 'http://192.168.1.4:3000/api/cancel',
    })

    return res.json(session)


    // const [rows] = await pool.query(`select ifnull(max(id), 0) idorden from orden where idstatus = 1 and idusuario = ${idusuario}`);
    
    // let idorden = rows[0].idorden;

    // const [pago] = await pool.query(` UPDATE orden SET idstatus = 3, fecha_actualizacion = now() WHERE id = ${idorden}`);

    // res.status(200).json({ data: {pago}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }

};

export const success = async (req, res) => {
  try {
    res.status(200).json({ message: 'OK' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const cancel = async (req, res) => {
  try {
    res.status(200).json({ message: 'OK' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const getEstados = async (req, res) => {
  try {

    let query = `select * from status where id >= 3 and id <> 7 and id <> 8 order by id asc`;

    const [rows] = await pool.query(query);

    res.json({data: rows, message: 'OK'});

  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getOrdenesAdmin = async (req, res) => {
  try {

    let query = `SELECT 
                  o.*,
                  s.nombre statusOrden ,
                  u.nombre nombreUsuario,
                  u.apellido apellidoUsuario,
                  u.telefono telefono,
                  u.email
                FROM orden o
                inner join status s on s.id = o.idstatus
                inner join usuarios u on u.id = o.idusuario order by o.id desc`;

    const [rows] = await pool.query(query);

    res.json({data: rows, message: 'OK'});
    
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const actualizarEstadoOrden = async (req, res) => {
  try {
    const { idOrden, nombreEstado } = req.body;
    
    const [id] = await pool.query(`select id from status where nombre = '${nombreEstado}'`);
    
    let idstatus = id[0].id;

    const [data] = await pool.query(`UPDATE orden SET idstatus = ${idstatus} WHERE id = ${idOrden}`);

    res.status(200).json({ data: {data}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const getOrdenesCliente = async (req, res) => {
  try {
    
    const { idusuario } = req.body;

    let query = `SELECT 
                  o.*,
                  s.nombre statusOrden
                FROM orden o
                inner join status s on s.id = o.idstatus where o.idusuario = ${idusuario} order by o.id desc`;

    const [rows] = await pool.query(query);

    res.json({data: rows, message: 'OK'});
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const confirmarOrdenRecibida = async (req, res) => {
  try {
    const { idorden } = req.body;

    const [data] = await pool.query(`UPDATE orden SET idstatus = 8 WHERE id = ${idorden}`);

    res.status(200).json({ data: {data}, message: 'OK' });
  
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};